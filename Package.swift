import PackageDescription

let package = Package(
  name: "GPXKit",
  dependencies: [
    .Package(url: "https://github.com/fousa/AEXML.git", majorVersion: 2, minor: 1)
  ]
)
