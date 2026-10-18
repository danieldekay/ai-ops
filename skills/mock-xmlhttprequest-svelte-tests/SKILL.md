---
name: "mock-xmlhttprequest-svelte-tests"
description: "Mock XMLHttpRequest in Svelte 5 + Vitest + jsdom tests"
version: 1
created: "2026-05-14"
updated: "2026-05-14"
---
## When to Use
When testing Svelte components that use `new XMLHttpRequest()` in Vitest with jsdom environment, and the XHR mock isn't working properly.

## Procedure
1. Create a `MockXhr` class with all required methods (open, send, setRequestHeader, status getter/setter, onload/onerror callbacks)
2. Create a constructor function that returns the singleton instance:
   ```ts
   let xhrInstance: MockXhr;
   function XhrConstructor() { return xhrInstance; }
   ```
3. In `beforeEach`:
   ```ts
   xhrInstance = new MockXhr();
   global.XMLHttpRequest = XhrConstructor as unknown as typeof window.XMLHttpRequest;
   ```
4. Provide a `resolveXhr(status, isError)` helper to trigger callbacks

**Critical**: The constructor function MUST return the singleton object when called with `new`. An arrow function `() => obj` won't work as a constructor.

## Pitfalls
- `vi.fn(() => obj)` doesn't work with `new` — it's not a constructor
- Creating a new `MockXhr()` in `beforeEach` and expecting the component to use it won't work — `new XMLHttpRequest()` creates a NEW instance
- The constructor function must return the singleton to make all instances refer to the same object

## Verification
Run `npx vitest run <test-file>` and verify all tests pass. Check that XHR calls are captured on the singleton instance.