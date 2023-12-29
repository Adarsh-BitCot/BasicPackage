// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BasicPackage",
    platforms: [
        .macOS(.v10_14), .iOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "BasicPackage",
            targets: ["BasicPackage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.7.1")),
        .package(url: "https://github.com/onevcat/Kingfisher", .upToNextMajor(from: "7.8.1")),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", .upToNextMajor(from: "5.17.0"))
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "BasicPackage",
            dependencies: ["Alamofire",
                           "Kingfisher",
                           "SDWebImage"],
            path: "Sources"),
        .testTarget(
            name: "BasicPackageTests",
            dependencies: ["BasicPackage"]),
    ]
)
