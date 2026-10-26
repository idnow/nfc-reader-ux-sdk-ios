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
        .package(url: "https://github.com/idnow/nfc-reader-sdk-ios.git", exact: "1.5.3"),
        .package(url: "https://github.com/idnow/sunflower-sdk-ios.git", exact: "2.2.2"),
    ],
    targets: [
        .binaryTarget(
            name: "NFCReaderUXLibrary",
            url: "https://github.com/idnow/nfc-reader-ux-sdk-ios/releases/download/1.4.3/NFCReaderUX.xcframework.zip",
            checksum: "f99bc126952c2bf2fb6c2c526ef88b0eb20a42f029f30f8797c11d86dadf0dfd"
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
