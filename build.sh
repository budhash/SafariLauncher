LASTDIR=`pwd`
rm -rf ./build
xcodebuild -project SafariLauncher.xcodeproj -configuration Debug SYMROOT=build
cd ./build/Debug-iphoneos/
zip -r SafariLauncher.zip SafariLauncher.app
cd $LASTDIR
