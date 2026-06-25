// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "NFCReaderUX",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "NFCReaderUXLibrary",
            targets: ["NFCReaderUXWrapper"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/idnow/nfc-reader-sdk-ios.git", exact: "1.4.1"),
        .package(url: "https://github.com/idnow/sunflower-sdk-ios.git", exact: "2.1.10"),
    ],
    targets: [
        .binaryTarget(
            name: "NFCReaderUXLibrary",
            url: "https://github.com/idnow/nfc-reader-ux-sdk-ios/releases/download/1.3.2/NFCReaderUX.xcframework.zip",
            checksum: "69ce61201f3696dd4b80ac2fc3032cf993e4cab3da8d86134fdd302290840e04"
        ),
        .target(
            // Main target which contains both NFCReaderUX and the NFCReader dependency. Automatically downloaded when client fetch NFCReader.
            name: "NFCReaderUXWrapper",
            dependencies: [
                "NFCReaderUXLibrary",
                .product(name: "NFCReaderLibrary", package: "nfc-reader-sdk-ios"),
                .product(name: "SunflowerUIKit", package: "sunflower-sdk-ios"),
            ],
            path: "sources"
        ),
    ]
)
