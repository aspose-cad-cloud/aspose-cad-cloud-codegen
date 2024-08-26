#!/bin/bash
export PackageVersion=$ENV_PackageVersion
echo "Change version to $PackageVersion"

echo "Update Java package version"
sed -i "s/\"artifactVersion\": \".*\"/\"artifactVersion\": \"$PackageVersion\"/" javaConfig.json

echo "Update .NET package version"
sed -i "s/\"packageVersion\": \".*\"/\"packageVersion\": \"$PackageVersion\"/" config.json

echo "Update NodeJs package version"
sed -i "s/\"npmVersion\": \".*\"/\"npmVersion\": \"$PackageVersion\"/" nodejsConfig.json

echo "Update PHP package version"
sed -i "s/\"artifactVersion\": \".*\"/\"artifactVersion\": \"$PackageVersion\"/" phpConfig.json

echo "Update Python package version"
sed -i "s/\"packageVersion\": \".*\"/\"packageVersion\": \"$PackageVersion\"/" pythonConfig.json

echo "Update Ruby package version"
sed -i "s/\"gemVersion\": \".*\"/\"gemVersion\": \"$PackageVersion\"/" rubyConfig.json

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