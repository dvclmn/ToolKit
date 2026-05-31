// swift-tools-version: 6.3

import PackageDescription

let package = Package(
  name: "ToolKit",
  platforms: [
    .macOS("14.0")
  ],
  products: [
    .library(
      name: "CoreTools",
      targets: [
        "CoreTools",
        "StringTools",
      ],
    ),
    .library(name: "ViewTools", targets: ["ViewTools"]),

    .library(
      name: "ColourTools",
      targets: [
        "ColourTools",
//        "ColourToolsCore",
      ],
    ),

  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
  ],
  targets: [
    .target(name: "CoreTools"),

    .target(name: "ColourTools", dependencies: ["CoreTools"]),
//    .target(name: "ColourToolsCore", dependencies: ["CoreTools"]),

    .target(name: "StringTools", dependencies: ["CoreTools"]),

    .target(name: "ViewTools", dependencies: ["CoreTools", "StringTools", "ColourTools"]),
  ],
)
