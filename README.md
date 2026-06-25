# NFCReaderUX for iOS

**NFCReaderUX** is the ready-to-use user experience for NFC document reading on iOS. It wraps the lower-level [NFCReader SDK](https://github.com/idnow/nfc-reader-sdk-ios) and drives the full on-screen flow — consent, reading, error/retry handling, and quitting — returning a structured result to your app.

The library is themed with the [IDnow Design System](https://github.com/idnow/sunflower-sdk-ios) (Sunflower).

---

## Requirements

| | |
|---|---|
| Platform | iOS 14.0+ |
| Language | Swift 5.9+ |
| Device | A physical iPhone with NFC (iPhone 7 and later). The NFC chip is **not** available in the iOS Simulator. |
| Distribution | Swift Package Manager (binary XCFramework) |

---

## Installation

The library is distributed as a binary XCFramework via Swift Package Manager. Its dependencies (NFCReader, Sunflower) are resolved automatically.

### Xcode

1. **File ▸ Add Package Dependencies…**
2. Enter the package repository URL.
3. Add the **`NFCReaderUXLibrary`** product to your app target.

---

## Project configuration

Reading an NFC document requires the Near Field Communication entitlement, an `NFCReaderUsageDescription`, and the ISO 7816 select identifiers in your **app** target. See the underlying [NFCReader SDK](https://github.com/idnow/nfc-reader-sdk-ios) for the exact `Info.plist` and entitlement entries.

---

## Quick start

A single static call kicks off the entire flow:

```swift
import NFCReaderUX

NFCReadingUX.startNFCReading(
    parentViewController: self,
    sessionConfiguration: NFCSessionConfiguration(...),
    translation: NFCTranslations(),     // optional, override copy
    eventListener: nil,                 // optional
    resultDelegate: self                // optional
)
```

Implement `NFCReaderResultDelegate` to receive the result:

```swift
extension MainViewModel: NFCReaderResultDelegate {
    func readResult(_ result: NFCResult) {
        switch result {
        case let .success(resultValue):
            print("✅ RESULT SUCCESS")
        case let .failure(error):
            print("❌ RESULT ERROR \(error)")
        }
    }
}
```

---

## Configuration

`NFCSessionConfiguration` controls the flow:

| Property | Description |
|---|---|
| `documentType` | The type of document to read. Impacts UX title and animation. |
| `nfcProtocol` | The credentials used to perform the reading — **CAN** or **MRZ**. |
| `nfcPollingOption` | The NFC polling mode — **iso14443** or **pace**. |
| `readerMode` | Whether reading/validation happens **remote** (online) or **local**. |
| `consentUrl` | Optional consent page URL. If unset, the consent tip is hidden. |
| `hideSkipButton` | Hides the "Skip this step" button when `true`. |

---

## Translations

The library ships English copy by default. Override any string by subclassing `NFCTranslations` and passing it to `startNFCReading`:

```swift
class MyCustomTranslations: NFCTranslations {
    // Override individual translations here
}
```

---

## Result

`NFCResult` reports the outcome of the flow:

| Type | Data Type |
|---|---|
| `NFCResult.success` | `NFCReadingResult` |
| `NFCResult.failure` | `NFCUxError` |

`NFCUxError` can be any of:

| Error | Description |
|---|---|
| `aborted` | The user aborted from the quit flow, with an optional reason. |
| `noMoreRetry` | The retry count was consumed. |
| `refusedConsent` | The user refused NFC read consent on the consent screen. |
| `readerError` | An error occurred during the NFC tag read operation. |

---

## Changelog

See [CHANGELOG.md](./CHANGELOG.md) for the full release history.

---

© IDnow. All rights reserved.
