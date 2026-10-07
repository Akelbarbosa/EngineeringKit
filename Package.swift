// swift-tools-version: 6.0
//
//  Package.swift
//  EngineeringKit
//
//  Created by Akel barbosa on 7/10/26.
//

import PackageDescription

/// Package compatibility and products; calculations remain independent of SwiftUI.
let package = Package(
    name: "EngineeringKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
    ],
    products: [
        // Consumers import this single module in apps, servers, or command-line tools.
        .library(name: "EngineeringKit", targets: ["EngineeringKit"]),
        // The executable illustrates typed units and cross-sectional properties.
        .executable(name: "EngineeringKitDemo", targets: ["EngineeringKitDemo"]),
    ],
    targets: [
        .target(name: "EngineeringKit"),
        .executableTarget(name: "EngineeringKitDemo", dependencies: ["EngineeringKit"]),
        .testTarget(name: "EngineeringKitTests", dependencies: ["EngineeringKit"]),
    ]
)
