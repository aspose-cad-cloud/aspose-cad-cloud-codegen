del /S /Q "c:\tmp\nodejs" || goto :error

java -jar codegen\swagger-codegen-cli-2.3.0.jar generate -i spec\asposeforcloud_word.json -l typescript-node -t codegen\Templates\nodejs -o c:/tmp/nodejs/ -c codegen\config.json || goto :error
xcopy "c:\tmp\nodejs\api.ts" "SDKs\node\src\api.ts" /Y || goto :error
xcopy "c:\tmp\nodejs\git_push.sh" "SDKs\node\src\model\model.ts" /Y || goto :error