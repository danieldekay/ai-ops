// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "TangocynicParakeet",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(url: "https://github.com/FluidInference/FluidAudio.git", exact: "0.12.4")
    ],
    targets: [
        .executableTarget(
            name: "TangocynicParakeet",
            dependencies: [.product(name: "FluidAudio", package: "FluidAudio")]
        )
    ]
)
