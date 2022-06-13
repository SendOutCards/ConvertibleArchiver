// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "ConvertibleArchiver",
    products: [
        .library(name: "ConvertibleArchiver", targets: ["ConvertibleArchiver"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SendOutCards/Convertible.git", .upToNextMajor(from: "6.0.0")),
    ],
    targets: [
        .target(name: "ConvertibleArchiver", dependencies: ["Convertible"]),
        .testTarget(name: "ConvertibleArchiverTests", dependencies: ["ConvertibleArchiver"]),
    ]
)
