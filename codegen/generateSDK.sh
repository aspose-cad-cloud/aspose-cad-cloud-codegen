#!/bin/bash
export PatchVersion=24.5.4
echo "Change version to $PatchVersion"

#sed -i "s/__VERSION__/$PatchVersion/g" ./config.json
#sed -i "s/__VERSION__/$PatchVersion/g" ./javaConfig.json
#sed -i "s/__VERSION__/$PatchVersion/g" ./phpConfig.json
#sed -i "s/__VERSION__/$PatchVersion/g" ./pythonConfig.json
#sed -i "s/__VERSION__/$PatchVersion/g" ./rubyConfig.json
#sed -i "s/__VERSION__/$PatchVersion/g" ./nodejsConfig.json

#sed -i 's/"packageVersion": "[^"]*"/"packageVersion": '$PatchVersion'/' input.json
#sed -i "s/\"packageVersion\": \"[^\"]*\"/\"packageVersion\": \"$PatchVersion\"/" ./config.json
#sed -i "s/\"packageVersion\": \"[^\"]*\"/\"packageVersion\": \"$PatchVersion\"/" config.json

#sed -i "s/packageVersion/$PatchVersion/g" ./Aspose.CAD.md
#sed -i 's/"packageVersion": "[^"]*"/"packageVersion": "25"/' ./config.json
#sed -i 's/"packageVersion": "[^"]*"/"packageVersion": "25"/g' ./config.json
#sed -i 's/"packageVersion": "[^"]*"/"packageVersion": "25"/' config.json


echo "Update Java package version"
sed -i "s/\"artifactVersion\": \".*\"/\"artifactVersion\": \"$PatchVersion\"/" javaConfig.json

echo "Update .NET package version"
sed -i "s/\"packageVersion\": \".*\"/\"packageVersion\": \"$PatchVersion\"/" config.json

echo "Update NodeJs package version"
sed -i "s/\"npmVersion\": \".*\"/\"npmVersion\": \"$PatchVersion\"/" nodejsConfig.json

echo "Update PHP package version"
sed -i "s/\"artifactVersion\": \".*\"/\"artifactVersion\": \"$PatchVersion\"/" phpConfig.json

echo "Update Python package version"
sed -i "s/\"packageVersion\": \".*\"/\"packageVersion\": \"$PatchVersion\"/" pythonConfig.json

echo "Update Ruby package version"
sed -i "s/\"gemVersion\": \".*\"/\"gemVersion\": \"$PatchVersion\"/" rubyConfig.json

echo "Build project for linux"

cd Tools
sh build.sh
cd ../

echo "Start generate SDKS"

sh generateJavaSDK.sh
sh generateNetSdk.sh
sh generateNodeJsSDK.sh
sh generatePhpSDK.sh
sh generatePythonSDK.sh
sh generateRubySDK.sh

echo "End generate SDKS"

exit 0;