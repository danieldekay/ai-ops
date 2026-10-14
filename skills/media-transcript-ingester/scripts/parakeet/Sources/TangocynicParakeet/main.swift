import Foundation
import FluidAudio

@main
struct TangocynicParakeet {
    static func main() async throws {
        let args = Array(CommandLine.arguments.dropFirst())
        guard let inputPath = args.first else {
            fputs("Usage: swift run TangocynicParakeet <video-or-audio-file-or-folder> [output-folder]\n", stderr)
            exit(2)
        }

        let inputURL = URL(fileURLWithPath: inputPath).standardizedFileURL
        let outputURL = URL(fileURLWithPath: args.dropFirst().first ?? "parakeet-transcripts", isDirectory: true)
            .standardizedFileURL
        let modelURL = modelDirectory()

        guard let modelURL else {
            throw ScriptError.missingModel("Set PARAKEET_MODEL_DIR or install VibeSonic with its Parakeet TDT v3 model")
        }

        let files = try inputFiles(at: inputURL)
        guard !files.isEmpty else { throw ScriptError.noMedia(inputURL.path) }
        try FileManager.default.createDirectory(at: outputURL, withIntermediateDirectories: true)

        // Load directly from VibeSonic's existing Core ML model directory; this API does not download models.
        let models = try await AsrModels.load(
            from: modelURL,
            configuration: AsrModels.defaultConfiguration(),
            version: .v3
        )
        let manager = AsrManager()
        try await manager.initialize(models: models)
        let converter = AudioConverter()
        var failures = 0

        for file in files {
            let output = outputURL.appendingPathComponent(file.deletingPathExtension().lastPathComponent + ".parakeet.txt")
            guard !FileManager.default.fileExists(atPath: output.path) else {
                print("SKIP exists: \(output.lastPathComponent)")
                continue
            }
            do {
                let audioURL = try audioInputURL(for: file)
                defer {
                    if audioURL != file { try? FileManager.default.removeItem(at: audioURL.deletingLastPathComponent()) }
                }
                let samples = try converter.resampleAudioFile(path: audioURL.path)
                let result = try await manager.transcribe(samples)
                try (result.text + "\n").write(to: output, atomically: true, encoding: .utf8)
                print("OK \(file.lastPathComponent) -> \(output.path)")
            } catch {
                failures += 1
                fputs("ERROR \(file.lastPathComponent): \(error)\n", stderr)
            }
        }
        manager.cleanup()
        if failures > 0 { throw ScriptError.transcriptionFailures(failures) }
    }

    private static func modelDirectory() -> URL? {
        let environment = ProcessInfo.processInfo.environment["PARAKEET_MODEL_DIR"]
        let candidates = [
            environment,
            NSHomeDirectory() + "/.vibesonic/models/parakeet-tdt-0.6b-v3-coreml",
            "/Applications/VibeSonic.app/Contents/Resources/models/parakeet-tdt-0.6b-v3-coreml",
            "/Applications/VibeSonic.app/Contents/Resources/parakeet-tdt-0.6b-v3-coreml",
        ].compactMap { $0 }
        return candidates.map { URL(fileURLWithPath: $0, isDirectory: true) }
            .first { FileManager.default.fileExists(atPath: $0.path) }
    }

    private static func inputFiles(at url: URL) throws -> [URL] {
        var isDirectory: ObjCBool = false
        guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) else {
            throw ScriptError.missingInput(url.path)
        }
        if !isDirectory.boolValue { return [url] }
        let allowed = Set(["mp4", "mov", "m4a", "wav", "mp3", "aiff", "flac"])
        return try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
            .filter { allowed.contains($0.pathExtension.lowercased()) }
            .sorted { $0.lastPathComponent.localizedStandardCompare($1.lastPathComponent) == .orderedAscending }
    }

    private static func audioInputURL(for file: URL) throws -> URL {
        guard ["mp4", "mov"].contains(file.pathExtension.lowercased()) else { return file }

        let ffmpeg = URL(fileURLWithPath: "/Applications/VibeSonic.app/Contents/Resources/ffmpeg")
        guard FileManager.default.isExecutableFile(atPath: ffmpeg.path) else {
            throw ScriptError.missingFFmpeg(ffmpeg.path)
        }

        let tempDirectory = FileManager.default.temporaryDirectory
            .appendingPathComponent("tangocynic-parakeet-\(UUID().uuidString)", isDirectory: true)
        try FileManager.default.createDirectory(at: tempDirectory, withIntermediateDirectories: true)
        let wavURL = tempDirectory.appendingPathComponent("audio.wav")
        let process = Process()
        process.executableURL = ffmpeg
        process.arguments = [
            "-nostdin", "-v", "error", "-y", "-i", file.path,
            "-vn", "-ac", "1", "-ar", "16000", "-c:a", "pcm_s16le", wavURL.path,
        ]
        let errors = Pipe()
        process.standardError = errors
        try process.run()
        process.waitUntilExit()
        let errorText = String(decoding: errors.fileHandleForReading.readDataToEndOfFile(), as: UTF8.self)
        guard process.terminationStatus == 0 else {
            try? FileManager.default.removeItem(at: tempDirectory)
            throw ScriptError.audioExtraction(file.lastPathComponent, errorText)
        }
        return wavURL
    }
}

enum ScriptError: Error, CustomStringConvertible {
    case missingModel(String)
    case missingInput(String)
    case noMedia(String)
    case missingFFmpeg(String)
    case audioExtraction(String, String)
    case transcriptionFailures(Int)

    var description: String {
        switch self {
        case .missingModel(let path): return "Parakeet model directory not found: \(path)"
        case .missingInput(let path): return "Input not found: \(path)"
        case .noMedia(let path): return "No supported media files found in: \(path)"
        case .missingFFmpeg(let path): return "VibeSonic's FFmpeg tool not found: \(path)"
        case .audioExtraction(let name, let detail): return "Audio extraction failed for \(name): \(detail)"
        case .transcriptionFailures(let count): return "\(count) media file(s) failed to transcribe"
        }
    }
}
