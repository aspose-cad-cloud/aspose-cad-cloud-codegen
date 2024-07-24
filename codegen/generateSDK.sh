#!/bin/bash
export PatchVersion=24.5.2
echo "Change version to $PatchVersion"

sed -i "s/__VERSION__/$PatchVersion/g" ./config.json
sed -i "s/__VERSION__/$PatchVersion/g" ./javaConfig.json
sed -i "s/__VERSION__/$PatchVersion/g" ./phpConfig.json
sed -i "s/__VERSION__/$PatchVersion/g" ./pythonConfig.json
sed -i "s/__VERSION__/$PatchVersion/g" ./rubyConfig.json
sed -i "s/__VERSION__/$PatchVersion/g" ./nodejsConfig.json

echo "Build project for linux"

cd Tools
sh build.sh
cd ../

echo "Start generate SDKS"

sh generateNetSdk.sh
sh generateJavaSDK.sh
sh generateRubySDK.sh
sh generatePythonSDK.sh
sh generatePhpSDK.sh
sh generatePhpSDK.sh

echo "End generate SDKS"

exit 0;