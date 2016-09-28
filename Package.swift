import PackageDescription

let package = Package(
  name: "TrackKit",
  dependencies: [
    .Package(url: "https://github.com/tadija/AEXML.git", majorVersion: 4, minor: 0)
  ]
)
