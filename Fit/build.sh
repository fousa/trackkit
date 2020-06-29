#!/usr/bin/env sh

# Cleanup the previous generated xcframework.
rm -rf "Fit.xcframework"

# Build the framework archives for multiple destination.
xcodebuild archive -scheme "Fit macOS" -destination "platform=macOS" -archivePath "./builds/Fit.macOS.xcarchive" SKIP_INSTALL=NO
xcodebuild archive -scheme "Fit iOS" -destination "platform=iOS Simulator,name=iPhone 11" -archivePath "./builds/Fit.iOSSimulator.xcarchive" SKIP_INSTALL=NO
xcodebuild archive -scheme "Fit iOS" -destination "generic/platform=iOS" -archivePath "./builds/Fit.iOS.xcarchive" SKIP_INSTALL=NO
xcodebuild archive -scheme "Fit iOS" -destination "platform=macOS,variant=Mac Catalyst" -archivePath "./builds/Fit.Catalyst.xcarchive" SKIP_INSTALL=NO

# Generate the xcframework for the differnt destinations.
xcodebuild -create-xcframework \
           -framework "./builds/Fit.macOS.xcarchive/Products/Library/Frameworks/Fit.framework" \
           -framework "./builds/Fit.iOSSimulator.xcarchive/Products/Library/Frameworks/Fit.framework" \
           -framework "./builds/Fit.iOS.xcarchive/Products/Library/Frameworks/Fit.framework" \
           -framework "./builds/Fit.Catalyst.xcarchive/Products/Library/Frameworks/Fit.framework" \
           -output "Fit.xcframework"

# Cleanup the builds.
rm -rf "./builds"