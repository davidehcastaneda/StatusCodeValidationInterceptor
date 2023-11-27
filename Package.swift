// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StatusCodeValidationInterceptor",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "StatusCodeValidationInterceptor",
            targets: ["StatusCodeValidationInterceptor"]),
    ],
    dependencies: [
        // Add your package dependencies here
        .package(url: "https://github.com/davidehcastaneda/NetworkRequest", branch: "main"),
        .package(url: "https://github.com/davidehcastaneda/NetworkClient", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "StatusCodeValidationInterceptor",
            dependencies: ["NetworkClient", "NetworkRequest"]),
        .testTarget(
            name: "StatusCodeValidationInterceptorTests",
            dependencies: ["StatusCodeValidationInterceptor"]),
    ]
)
