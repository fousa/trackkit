#!/usr/bin/env sh

# Cleanup the previous generated xcframework.
rm -rf "TrackKit.xcframework"
# Cleanup the builds.
rm -rf "./builds"

# Build the framework archives for multiple destination.
xcodebuild archive -scheme "TrackKit iOS" -destination "platform=iOS Simulator,name=iPhone 11" -archivePath "./builds/TrackKit.iOSSimulator.xcarchive" SKIP_INSTALL=NO
xcodebuild archive -scheme "TrackKit iOS" -destination "generic/platform=iOS" -archivePath "./builds/TrackKit.iOS.xcarchive" SKIP_INSTALL=NO
xcodebuild archive -scheme "TrackKit iOS" -destination "platform=macOS,variant=Mac Catalyst" -archivePath "./builds/TrackKit.Catalyst.xcarchive" SKIP_INSTALL=NO

# Generate the xcframework for the differnt destinations.
xcodebuild -create-xcframework \
           -framework "./builds/TrackKit.iOSSimulator.xcarchive/Products/Library/Frameworks/TrackKit.framework" \
           -framework "./builds/TrackKit.iOS.xcarchive/Products/Library/Frameworks/TrackKit.framework" \
           -framework "./builds/TrackKit.Catalyst.xcarchive/Products/Library/Frameworks/TrackKit.framework" \
           -output "TrackKit.xcframework"
