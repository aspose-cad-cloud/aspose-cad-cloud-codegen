#!/bin/bash

echo "======= PYTHON ======="

sdkfolder="../SDKS/Python"
tmpfolder="/tmp/python"

if [ -d "$tmpfolder" ]; then
  rm -rf "$tmpfolder" || { echo "Failed to delete $tmpfolder"; exit 1; }
fi

java -jar swagger-codegen-cli-2.4.5.jar generate -i ../spec/asposeforcloud_cad_without_disciminator.json -l python -t Templates/python -c pythonConfig.json -o $tmpfolder || { echo "Swagger code generation failed"; exit 1; }

Tools/SplitPythonCodeFile/bin/Release/netcoreapp3.1/linux-x64/publish/./SplitPythonCodeFile "$tmpfolder/asposecadcloud/api/cad_api.py" "$tmpfolder/asposecadcloud/models/requests/" || { echo "SplitPythonCodeFile failed"; exit 1; }

if [ -d "$sdkfolder/docs" ]; then
  rm -rf "$sdkfolder/docs" || { echo "Failed to delete $sdkfolder/docs"; exit 1; }
fi

if [ -d "$sdkfolder/asposecadcloud" ]; then
  echo "delete $sdkfolder/asposecadcloud" 
  rm -rf "$sdkfolder/asposecadcloud" || { echo "Failed to delete $sdkfolder/asposecadcloud"; exit 1; }
fi

cp -r "$tmpfolder/docs/." "$sdkfolder/docs" || { echo "Failed to copy docs"; exit 1; }
cp -r "$tmpfolder/asposecadcloud/." "$sdkfolder/asposecadcloud" || { echo "Failed to copy Api"; exit 1; }

cp -r "$tmpfolder/README.md" "$sdkfolder/README.md" || { echo "Failed to copy README.md"; exit 1; }
cp -r "$tmpfolder/setup.py" "$sdkfolder/setup.py" || { echo "Failed to copy setup.py"; exit 1; }