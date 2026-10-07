// swift-tools-version: 6.0
//
//  Package.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import PackageDescription

/// A separate package verifies that consumers need only the public library product.
let package = Package(
    name: "PackageConsumer",
    platforms: [.macOS(.v13)],
    dependencies: [.package(path: "../..")],
    targets: [
        .executableTarget(
            name: "PackageConsumer",
            dependencies: [.product(name: "EngineeringKit", package: "EngineeringKit")]
        ),
    ]
)
