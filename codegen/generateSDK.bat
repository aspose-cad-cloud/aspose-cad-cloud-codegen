del /S /Q "c:\tmp\csharp" || goto :error
java -jar SDKs\codegen\swagger-codegen-cli-2.3.0.jar generate -i SDKs\spec\asposeforcloud_word.json -l csharp -t SDKs\codegen\Templates\csharp -o c:/tmp/csharp/ -c SDKs\codegen\config.json || goto :error

SDKs\codegen\Tools\SplitCSharpCodeFile.exe C:\tmp\csharp\src\Aspose.Words.Cloud.Sdk\Api\WordsApi.cs C:\tmp\csharp\src\Aspose.Words.Cloud.Sdk\Model\Requests\ || goto :error

del /S /Q "SDKs\NET\Aspose.Words.Cloud.Sdk\Model" || goto :error
del /S /Q "SDKs\NET\Aspose.Words.Cloud.Sdk\Api\WordsApi.cs" || goto :error

xcopy "c:\tmp\csharp\src\Aspose.Words.Cloud.Sdk\Model" "SDKs\NET\Aspose.Words.Cloud.Sdk\Model" /E || goto :error
xcopy "c:\tmp\csharp\src\Aspose.Words.Cloud.Sdk\Api" "SDKs\NET\Aspose.Words.Cloud.Sdk\Api" /E || goto :error

del /S /Q "c:\tmp\php" || goto :error
java -jar SDKs\codegen\swagger-codegen-cli-2.3.0.jar generate -i SDKs\spec\asposeforcloud_word.json -l php -t SDKs\codegen\Templates\php -o c:/tmp/php/ --invoker-package Aspose\Words --model-package Model --api-package Api || goto :error

SDKs\codegen\Tools\SplitPhpCodeFile.exe C:\tmp\php\SwaggerClient-php\lib\Api\WordsApi.php C:\tmp\php\SwaggerClient-php\lib\Model\Requests\ || goto :error

del /S /Q "SDKs\PHP\src" || goto :error

xcopy "C:\tmp\php\SwaggerClient-php\lib\Api" "SDKs\PHP\src\Aspose\Words" /E || goto :error
del /S /Q "C:\tmp\php\SwaggerClient-php\lib\Api" || goto :error
rmdir "C:\tmp\php\SwaggerClient-php\lib\Api" || goto :error
xcopy "C:\tmp\php\SwaggerClient-php\lib" "SDKs\PHP\src\Aspose\Words" /E || goto :error
xcopy /y "C:\tmp\php\SwaggerClient-php\composer.json" "SDKs\PHP" || goto :error
xcopy /y "SDKs\codegen\BuildFiles\composer.phar" "SDKs\PHP" || goto :error
xcopy /y "SDKs\codegen\BuildFiles\RepeatRequestException.php" "SDKs\PHP\src\Aspose\Words" || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%








