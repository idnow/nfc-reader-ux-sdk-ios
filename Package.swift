// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "NFCReaderUX",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "NFCReaderUXLibrary",
            targets: ["NFCReaderUXWrapper"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/idnow/nfc-reader-sdk-ios.git", exact: "1.5.3"),
        .package(url: "https://github.com/idnow/sunflower-sdk-ios.git", exact: "2.3.1"),
    ],
    targets: [
        .binaryTarget(
            name: "NFCReaderUXLibrary",
            url: "https://github.com/idnow/nfc-reader-ux-sdk-ios/releases/download/1.5.1/NFCReaderUX.xcframework.zip",
            checksum: "5ef0205fe80c77d507ee307b143c7d811c1e9d801a6d240c3ceea2581ef5fa67"
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
