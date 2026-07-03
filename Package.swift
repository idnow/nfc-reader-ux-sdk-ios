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
        .package(url: "https://github.com/idnow/nfc-reader-sdk-ios.git", exact: "1.4.2"),
        .package(url: "https://github.com/idnow/sunflower-sdk-ios.git", exact: "2.1.17"),
    ],
    targets: [
        .binaryTarget(
            name: "NFCReaderUXLibrary",
            url: "https://github.com/idnow/nfc-reader-ux-sdk-ios/releases/download/1.3.6/NFCReaderUX.xcframework.zip",
            checksum: "f42dfaefc3b9bb0d2c49ac95b91d579322fc42a86f3599defaa9d69823f0640c"
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
