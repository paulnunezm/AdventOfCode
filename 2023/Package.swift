// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AOC_2023",
    dependencies: [
      .package(url: "https://github.com/apple/example-package-figlet", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "AOC_2023",
            dependencies: [
                .product(name: "Figlet", package: "example-package-figlet"),
            ],
            resources: [
                .copy("Resources/")]
        )
        
    ]
)
