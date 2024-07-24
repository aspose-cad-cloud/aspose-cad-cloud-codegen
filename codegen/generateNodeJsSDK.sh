#!/bin/bash

echo "======= NodeJS ======="

sdkfolder="../SDKS/NodeJs"
rootfolder="../spec"
tmpfolder="/tmp/nodejs"

cp -f "Templates/nodejs/.swagger-codegen-ignore" "$sdkfolder/.swagger-codegen-ignore" || { echo "Failed to copy .swagger-codegen-ignore"; exit 1; }

if [ -f "$sdkfolder/lib/api.ts" ]; then
  rm -f "$sdkfolder/lib/api.ts" || { echo "Failed to delete api.ts"; exit 1; }
fi

if [ -f "$sdkfolder/lib/model/model.ts" ]; then
  rm -f "$sdkfolder/lib/model/model.ts" || { echo "Failed to delete model.ts"; exit 1; }
fi

java -jar swagger-codegen-cli-2.4.5.jar generate -i ../spec/asposeforcloud_cad_without_disciminator.json -l typescript-fetch -t Templates/nodejs -o $tmpfolder -c nodejsConfig.json || { echo "Swagger code generation failed"; exit 1; }

if [ ! -d "$sdkfolder/lib" ]; then
  mkdir -p "$sdkfolder/lib" || { echo "Failed to create directory"; exit 1; }
fi

mv -f "$tmpfolder/api.ts" "$sdkfolder/lib/api.ts" || { echo "Failed to move api.ts"; exit 1; }
mv -f "$tmpfolder/git_push.sh" "$sdkfolder/lib/model/model.ts" || { echo "Failed to move git_push.sh"; exit 1; }

mv -f "$tmpfolder/configuration.ts" "$sdkfolder/lib/internal/request-helper.ts" || { echo "Failed to move api.ts"; exit 1; }

mv -f "$tmpfolder/index.ts" "$sdkfolder/package.json" || { echo "Failed to move git_push.sh"; exit 1; }
mv -f "$tmpfolder/custom.d.ts" "$sdkfolder/README.md" || { echo "Failed to move git_push.sh"; exit 1; }

cd Tools
pwsh -NoProfile -ExecutionPolicy Bypass -Command ". './nodejs.ps1' '../$sdkfolder/' '../$rootfolder/asposeforcloud_cad_without_disciminator.json'" || { echo "NodeJs generation failed with error"; exit 1; }
cd ..