#!/bin/bash

echo "======= JAVA ======="

sdkfolder="../SDKS/Java"
tmpfolder="/tmp/java"

if [ -d "$tmpfolder" ]; then
  rm -rf "$tmpfolder" || { echo "Failed to delete $tmpfolder"; exit 1; }
fi

java -jar swagger-codegen-cli-2.4.5.jar generate -i ../spec/asposeforcloud_cad_without_disciminator.json -l java --import-mappings JfifData=JfifData -DsupportJava6=true -DdateLibrary=legacy -t Templates/java -o $tmpfolder -c javaConfig.json || { echo "Swagger code generation failed"; exit 1; }

Tools/SplitJavaCodeFile/bin/Release/netcoreapp3.1/linux-x64/publish/./SplitJavaCodeFile "$tmpfolder/src/main/java/com/aspose/cad/cloud/api/CadApi.java" "$tmpfolder/src/main/java/com/aspose/cad/cloud/model/requests/" || { echo "SplitJavaCodeFile failed"; exit 1; }

if [ -d "$sdkfolder/src/main/java/com/aspose/cad/cloud/model" ]; then
  rm -rf "$sdkfolder/src/main/java/com/aspose/cad/cloud/model" || { echo "Failed to delete $sdkfolder/src/main/java/com/aspose/cad/cloud/model"; exit 1; }
fi

if [ -d "$sdkfolder/src/main/java/com/aspose/cad/cloud/api/CadApi.java" ]; then
  rm -rf "$sdkfolder/src/main/java/com/aspose/cad/cloud/api/CadApi.java" || { echo "Failed to delete $sdkfolder/src/main/java/com/aspose/cad/cloud/api/CadApi.java"; exit 1; }
fi

cp -r "$tmpfolder/docs/." "$sdkfolder/docs" || { echo "Failed to copy docs"; exit 1; }
cp -r "$tmpfolder/src/main/java/com/aspose/cad/cloud/model/." "$sdkfolder/src/main/java/com/aspose/cad/cloud/model" || { echo "Failed to copy Model"; exit 1; }
cp -r "$tmpfolder/src/main/java/com/aspose/cad/cloud/api/CadApi.java" "$sdkfolder/src/main/java/com/aspose/cad/cloud/api" || { echo "Failed to copy Api"; exit 1; }

cp -r "$tmpfolder/pom.xml" "$sdkfolder/pom.xml" || { echo "Failed to copy Api"; exit 1; }
cp -r "$tmpfolder/README.md" "$sdkfolder/README.md" || { echo "Failed to copy Api"; exit 1; }