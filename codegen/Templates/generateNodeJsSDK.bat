del /S /Q "c:\tmp\nodejs" || goto :error

java -jar SDKs\codegen\swagger-codegen-cli-2.3.0.jar generate -i SDKs\spec\asposeforcloud_word.json -l typescript-node -t SDKs\codegen\Templates\nodejs -o c:/tmp/nodejs/ -c SDKs\codegen\config.json || goto :error
xcopy "c:\tmp\nodejs\api.ts" "SDKs\nodejs\src\api.ts" /Y || goto :error
xcopy "c:\tmp\nodejs\git_push.sh" "SDKs\nodejs\src\model\model.ts" /Y || goto :error