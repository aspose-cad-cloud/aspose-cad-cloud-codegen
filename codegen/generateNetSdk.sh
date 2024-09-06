#!/bin/bash

echo "======= .NET ======="

sdkfolder="../SDKS/NET"
tmpfolder="/tmp/csharp"

if [ -d "$tmpfolder" ]; then
  rm -rf "$tmpfolder" || { echo "Failed to delete $tmpfolder"; exit 1; }
fi

if [ -d "$sdkfolder/docs" ]; then
  rm -rf "$sdkfolder/docs" || { echo "Failed to delete $sdkfolder/docs"; exit 1; }
fi

java -jar swagger-codegen-cli-2.4.5.jar generate -i "../spec/asposeforcloud_cad_without_disciminator.json" -l csharp -t Templates/csharp -o "$tmpfolder" -c config.json || { echo "Swagger code generation failed"; exit 1; }

mkdir -p $sdkfolder/docs/

mv "$tmpfolder/README.md" "$sdkfolder/docs/API_README.md" || { echo "Failed to move README.md"; exit 1; }

Tools/SplitCSharpCodeFile/bin/Release/netcoreapp3.1/linux-x64/publish/./SplitCSharpCodeFile "/tmp/csharp/src/Aspose.CAD.Cloud.Sdk/Api/CadApi.cs" "/tmp/csharp/src/Aspose.CAD.Cloud.Sdk/Model/Requests/" || { echo "SplitCSharpCodeFile failed"; exit 1; }

Tools/PostProcessor/bin/Release/netcoreapp3.1/linux-x64/publish/./PostProcessor "../spec/asposeforcloud_cad.json" "/tmp/csharp/src/Aspose.CAD.Cloud.Sdk" || { echo "PostProcessor.exe failed"; exit 1; }

if [ -d "$sdkfolder/src/Aspose.CAD.Cloud.Sdk/Model" ]; then
  rm -rf "$sdkfolder/src/Aspose.CAD.Cloud.Sdk/Model" || { echo "Failed to delete $sdkfolder/src/Aspose.CAD.Cloud.Sdk/Model"; exit 1; }
fi

if [ -d "$sdkfolder/src/Aspose.CAD.Cloud.Sdk/Api/CadApi.cs" ]; then
  rm -f "$sdkfolder/src/Aspose.CAD.Cloud.Sdk/Api/CadApi.cs" || { echo "Failed to delete $sdkfolder/src/Aspose.CAD.Cloud.Sdk/Api/CadApi.cs"; exit 1; }
fi

cp -r "$tmpfolder/docs/." "$sdkfolder/docs" || { echo "Failed to copy docs"; exit 1; }
cp -r "$tmpfolder/src/Aspose.CAD.Cloud.Sdk/Model/." "$sdkfolder/src/Aspose.CAD.Cloud.Sdk/Model" || { echo "Failed to copy Model"; exit 1; }
cp -r "$tmpfolder/src/Aspose.CAD.Cloud.Sdk/Api/." "$sdkfolder/src/Aspose.CAD.Cloud.Sdk/Api" || { echo "Failed to copy Api"; exit 1; }

cp -r "$tmpfolder/src/Aspose.CAD.Cloud.Sdk/Aspose.CAD.Cloud.Sdk.csproj" "$sdkfolder/src/Aspose.CAD.Cloud.Sdk/Aspose.CAD.Cloud.Sdk.csproj" || { echo "Failed to copy Model"; exit 1; }
cp -r "$tmpfolder/src/Aspose.CAD.Cloud.Sdk/Aspose.CAD.Cloud.Sdk.nuspec" "$sdkfolder/Aspose.CAD.Cloud.Sdk.nuspec" || { echo "Failed to copy Api"; exit 1; }