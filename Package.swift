// swift-tools-version:5.2
import PackageDescription

let package: Package = .init(
    name: "TrackKit",
    platforms: [
        .macOS(.v10_11), 
        .iOS(.v12)
    ],
    products: [
        .library(name: "TrackKit", targets: ["TrackKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/tadija/AEXML.git", from: "4.5.0")
    ],
    targets: [
        .target(name: "TrackKit", dependencies: ["AEXML", "Fit"]),
        .target(name: "Fit", dependencies: ["FitSDK"]),
        .target(name: "FitSDK")
    ],
    cxxLanguageStandard: CXXLanguageStandard.cxx11
)