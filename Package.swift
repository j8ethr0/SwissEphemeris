// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SwissEphemeris",
    products: [
        .library(
            name: "SwissEphemeris",
            targets: ["SwissEphemeris"]
        ),
        .library(name: "CSwissEphemeris", targets: ["CSwissEphemeris"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwissEphemeris",
            dependencies: ["CSwissEphemeris"]
        ),
        .target(
            name: "CSwissEphemeris",
            path: "Sources/CSwissEphemeris",
            publicHeadersPath: "include"
        ),
        .testTarget(
            name: "SwissEphemerisTests",
            dependencies: ["SwissEphemeris"]
        ),
    ]
)
