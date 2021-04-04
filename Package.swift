// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "CaseName",
    platforms: [
        .iOS(.v9),
        .tvOS(.v9),
        .watchOS(.v2),
        .macOS(.v10_10)
    ],
    products: [
        .library(
            name: "CaseName",
            targets: ["CaseName"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CaseName",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "CaseNameTests",
            dependencies: ["CaseName"],
            path: "Tests"
        ),
    ]
)
