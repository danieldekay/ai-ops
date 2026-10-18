---
name: "pwa-install-update-detection"
description: "Implement PWA install state management, update detection, and platform-specific install instructions for SvelteKit applications. Covers reactive state stores with Svelte 5 runes, beforeinstallprompt handling, Service Worker update detection, and accessible modal patterns."
version: 2
created: "2026-05-13"
updated: "2026-05-13"
---
# PWA Install + Update Detection

## When to Use
- Adding PWA install prompts to SvelteKit applications
- Implementing Service Worker update detection and banners
- Creating platform-specific install instructions (iOS, Firefox, Samsung)
- Building accessible modal dialogs with focus management

## Procedure
## Procedure

### 1. Create Reactive PWA Install State Store
Create `src/lib/utils/pwa-install-state.ts` using Svelte 5 runes:

```typescript
let browser = $state<"chrome" | "edge" | "safari" | "firefox" | "samsung" | "unknown">("unknown");
let os = $state<"ios" | "android" | "windows" | "macos" | "linux" | "unknown">("unknown");
let canInstall = $state(false);
let installMethod = $state<"native-prompt" | "ios-instructions" | "firefox-link" | "samsung-native" | "none">("none");
let supportsNativePrompt = $state(false);
let isInstalled = $state(false);

export const pwaInstallState = $derived({
  browser,
  os,
  canInstall,
  installMethod,
  supportsNativePrompt
});

export function initPwaInstallState(): void {
  browser = getBrowser();
  os = getOS();
  installMethod = getInstallMethod();
  supportsNativePrompt = supportsNativeInstallPrompt();
  isInstalled = isSafariStandalone();
  canInstall = !isInstalled && installMethod !== "none";
}
```

### 2. Install Prompt Timing Utility
Create `src/lib/pwa.ts` for localStorage-based timing:

```typescript
const BROWSE_COUNT_KEY = 'pwa_event_browse_count';
const INSTALL_DISMISSED_KEY = 'pwa_install_dismissed';
const BROWSE_THRESHOLD = 2;

export function incrementBrowseCount(): void {
  const cur = parseInt(localStorage.getItem(BROWSE_COUNT_KEY) ?? '0', 10);
  localStorage.setItem(BROWSE_COUNT_KEY, String(cur + 1));
}

export function shouldShowInstallPrompt(): boolean {
  try {
    const count = parseInt(localStorage.getItem(BROWSE_COUNT_KEY) ?? '0', 10);
    const dismissed = localStorage.getItem(INSTALL_DISMISSED_KEY) === '1';
    return count >= BROWSE_THRESHOLD && !dismissed;
  } catch {
    return false;
  }
}

export function dismissInstallPrompt(): void {
  try {
    localStorage.setItem(INSTALL_DISMISSED_KEY, '1');
  } catch { /* ignore quota errors */ }
}
```

### 3. Browser/OS Detection Utilities
Create `src/lib/utils/pwa-install.ts`:
- Detect browser type from user agent
- Detect OS platform
- Determine install method based on browser/OS combination
- Check for Safari standalone mode (PWA installed on iOS)

### 4. BeforeInstallPrompt Event Handling
In main component:
```typescript
let installPromptEvent = $state<BeforeInstallPromptEvent | null>(null);

const handleBeforeInstall = (e: Event) => {
  e.preventDefault();
  installPromptEvent = e as BeforeInstallPromptEvent;
  if (shouldShowInstallPrompt()) {
    showInstallBanner = true;
  }
};
window.addEventListener('beforeinstallprompt', handleBeforeInstall);
```

### 5. Service Worker Update Detection
```typescript
navigator.serviceWorker.getRegistration().then((reg) => {
  if (reg?.waiting) {
    waitingWorker = reg.waiting;
    showUpdateBanner = true;
  }
  reg?.addEventListener('updatefound', () => {
    const newWorker = reg.installing;
    newWorker?.addEventListener('statechange', () => {
      if (newWorker.state === 'installed' && navigator.serviceWorker.controller) {
        waitingWorker = newWorker;
        showUpdateBanner = true;
      }
    });
  });
});
```

### 6. Accessible Modal Pattern
Create modal component with:
- Focus trap and body scroll prevention
- Escape key handler
- Overlay click to close
- Proper ARIA attributes (role="dialog", aria-modal="true")
- CSS transitions with prefers-reduced-motion support

### 7. Install Instructions Modals
Create platform-specific instruction components:
- iOS: Share button → Add to Home Screen
- Firefox: Link to MDN instructions
- Samsung: Browser menu navigation
## Pitfalls
- **SSR safety**: Always check `typeof window !== "undefined"` before accessing browser APIs
- **Event listener cleanup**: Remove event listeners on component destroy
- **Modal scroll lock**: Use try/finally to restore overflow on cleanup
- **Service Worker scope**: Ensure SW scope matches your deployment (Cloudflare Worker Assets needs careful configuration)