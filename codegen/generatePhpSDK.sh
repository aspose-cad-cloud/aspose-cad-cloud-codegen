#!/bin/bash

echo "======= PHP ======="

sdkfolder="../SDKS/PHP"
tmpfolder="/tmp/PHP"

if [ -d "$tmpfolder" ]; then
  rm -rf "$tmpfolder" || { echo "Failed to delete $tmpfolder"; exit 1; }
fi

java -jar swagger-codegen-cli-2.4.5.jar generate -i ../spec/asposeforcloud_cad_without_disciminator.json -l php -t Templates/php -c phpConfig.json -o "$tmpfolder" --invoker-package Aspose/CAD --model-package Model --api-package Api || { echo "Swagger code generation failed"; exit 1; }

Tools/SplitPhpCodeFile/bin/Release/netcoreapp3.1/linux-x64/publish/./SplitPhpCodeFile "$tmpfolder/SwaggerClient-php/lib/Api/CadApi.php" "$tmpfolder/SwaggerClient-php/lib/Model/Requests/" || { echo "SplitPhpCodeFile failed"; exit 1; }

if [ -d "$sdkfolder/docs" ]; then
  rm -rf "$sdkfolder/docs" || { echo "Failed to delete $sdkfolder/docs"; exit 1; }
fi

if [ -d "$sdkfolder/src/Aspose/CAD/Model" ]; then
  rm -rf "$sdkfolder/src/Aspose/CAD/Model" || { echo "Failed to delete $sdkfolder/src/Aspose/CAD/Model"; exit 1; }
fi

if [ -d "$sdkfolder/src/Aspose/CAD/CadApi.php" ]; then
  rm -rf "$sdkfolder/src/Aspose/CAD/CadApi.php" || { echo "Failed to delete $sdkfolder/src/Aspose/CAD/CadApi.php"; exit 1; }
fi

cp -r "$tmpfolder/SwaggerClient-php/docs/Api/." "$sdkfolder/docs" || { echo "Failed to copy docs"; exit 1; }
cp -r "$tmpfolder/SwaggerClient-php/docs/Model/." "$sdkfolder/docs" || { echo "Failed to copy docs"; exit 1; }
cp -r "$tmpfolder/SwaggerClient-php/lib/Model/." "$sdkfolder/src/Aspose/CAD/Model" || { echo "Failed to copy docs"; exit 1; }

rm -rf "$tmpfolder/SwaggerClient-php/lib/Model" || { echo "Failed to delete $tmpfolder/SwaggerClient-php/lib/Model"; exit 1; }

rm -rf "$tmpfolder/SwaggerClient-php/lib/Model/Requests" || { echo "Failed to delete $tmpfolder/SwaggerClient-php/lib/Model/Requests"; exit 1; }
rm -rf "$tmpfolder/SwaggerClient-php/lib/Model" || { echo "Failed to delete $tmpfolder/SwaggerClient-php/lib/Model"; exit 1; }

cp -r "$tmpfolder/SwaggerClient-php/lib/Api/." "$sdkfolder/src/Aspose/CAD" || { echo "Failed to copy $tmpfolder/SwaggerClient-php/lib/Api"; exit 1; }
cp -r "$tmpfolder/SwaggerClient-php/lib/Configuration.php" "$sdkfolder/src/Aspose/CAD" || { echo "Failed to copy $tmpfolder/SwaggerClient-php/lib/Configuration.php"; exit 1; }

cp -r "$tmpfolder/SwaggerClient-php/lib/README.md" "$sdkfolder/README.md" || { echo "Failed to copy $tmpfolder/SwaggerClient-php/README.md"; exit 1; }
cp -r "$tmpfolder/SwaggerClient-php/lib/composer.json" "$sdkfolder/composer.json" || { echo "Failed to copy $tmpfolder/SwaggerClient-php/composer.json"; exit 1; }