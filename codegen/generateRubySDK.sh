#!/bin/bash

echo "======= RUBY ======="

sdkfolder="../SDKS/Ruby"
tmpfolder="/tmp/ruby"

if [ -d "$tmpfolder" ]; then
  rm -rf "$tmpfolder" || { echo "Failed to delete $tmpfolder"; exit 1; }
fi

java -jar swagger-codegen-cli-2.3.0.jar generate -i ../spec/asposeforcloud_cad_without_disciminator.json -l ruby -t Templates/ruby -c rubyConfig.json -o $tmpfolder || { echo "Swagger code generation failed"; exit 1; }

Tools/SplitRubyCodeFile/bin/Release/netcoreapp3.1/linux-x64/publish/./SplitRubyCodeFile "$tmpfolder/lib/aspose_cad_cloud/api/cad_api.rb" "$tmpfolder/lib/aspose_cad_cloud/models/requests/" || { echo "SplitRubyCodeFile failed"; exit 1; }

if [ -d "$sdkfolder/lib" ]; then
  rm -rf "$sdkfolder/lib" || { echo "Failed to delete $sdkfolder/lib"; exit 1; }
fi

cp -r "$tmpfolder/lib" "$sdkfolder/lib" || { echo "Failed to copy lib"; exit 1; }

cp -r "$tmpfolder/README.md" "$sdkfolder/README.md" || { echo "Failed to copy lib"; exit 1; }