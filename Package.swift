// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "swift-3x-test-project",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.89.0")
    ],
    targets: [
        .target(name: "App", dependencies: [.product(name: "Vapor", package: "vapor")]),
        .executableTarget(name: "Run", dependencies: ["App"])
    ]
)
