// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "cross-arch-compilation-with-macros",
    platforms: [.macOS("15.0")],
    dependencies: [
        .package(url: "https://github.com/Kolos65/Mockable", from: "0.0.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "cross-arch-compilation-with-macros",
            dependencies: [
                .product(name: "Mockable", package: "Mockable")
            ],
            swiftSettings: [
                .define("MOCKING", .when(configuration: .debug))
            ]),
    ]
)
