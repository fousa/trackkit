######################
# Options
######################
FRAMEWORK_NAME="Fit"

FRAMEWORK="${BUILD_DIR}/${CONFIGURATION}/${FRAMEWORK_NAME}.framework"

######################
# On Release, copy the result to release directory
######################

rm -rf "${PROJECT_DIR}/../Sources/Vendor/macOS/Fit.framework"
cp -R -P "${FRAMEWORK}" "${PROJECT_DIR}/../Sources/Vendor/macOS/"
