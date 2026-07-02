// swift-tools-version: 6.3

import PackageDescription

let package = Package(
  name: "ToolKit",
  platforms: [
    .macOS(.v14)
  ],
  products: [
    .library(name: "CoreTools", targets: ["CoreTools"]),
    .library(name: "StringTools", targets: ["StringTools"]),
    .library(name: "ViewTools", targets: ["ViewTools"]),
    .library(name: "ColourTools", targets: ["ColourTools"]),

  ],
  dependencies: [
    .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.0.0")
  ],
  targets: [
    .target(name: "CoreTools"),
    .target(name: "ColourTools", dependencies: ["CoreTools"]),
    .target(name: "StringTools", dependencies: ["CoreTools"]),
    .target(
      name: "ViewTools",
      dependencies: ["CoreTools", "StringTools", "ColourTools"],
      resources: [.process("Resources")],
    ),
    .testTarget(
      name: "CoreToolsTests",
      dependencies: ["CoreTools"],
      exclude: ["CoreTools.xctestplan"],
    ),
    .testTarget(name: "ColourToolsTests", dependencies: ["ColourTools"]),
  ],
)
