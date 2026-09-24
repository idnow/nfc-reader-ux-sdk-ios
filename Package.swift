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
        .package(url: "https://github.com/idnow/nfc-reader-sdk-ios.git", exact: "1.5.0"),
        .package(url: "https://github.com/idnow/sunflower-sdk-ios.git", exact: "2.2.2"),
    ],
    targets: [
        .binaryTarget(
            name: "NFCReaderUXLibrary",
            url: "https://github.com/idnow/nfc-reader-ux-sdk-ios/releases/download/1.4.0/NFCReaderUX.xcframework.zip",
            checksum: "7c149e2f517c2490dcfd3e91f4f28f5bc42ca97bf3bc47ed50a31e4b2160b141"
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
