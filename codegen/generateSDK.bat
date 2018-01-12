del /S /Q "c:\tmp\csharp" || goto :error
java -jar codegen\swagger-codegen-cli-2.3.0.jar generate -i spec\asposeforcloud_word.json -l csharp -t codegen\Templates\csharp -o c:/tmp/csharp/ -c codegen\config.json || goto :error

codegen\Tools\SplitCSharpCodeFile.exe C:\tmp\csharp\src\Aspose.Words.Cloud.Sdk\Api\WordsApi.cs C:\tmp\csharp\src\Aspose.Words.Cloud.Sdk\Model\Requests\ || goto :error

del /S /Q "SDKs\NET\Aspose.Words.Cloud.Sdk\Model" || goto :error
del /S /Q "SDKs\NET\Aspose.Words.Cloud.Sdk\Api\WordsApi.cs" || goto :error

xcopy "c:\tmp\csharp\src\Aspose.Words.Cloud.Sdk\Model" "SDKs\NET\Aspose.Words.Cloud.Sdk\Model" /E || goto :error
xcopy "c:\tmp\csharp\src\Aspose.Words.Cloud.Sdk\Api" "SDKs\NET\Aspose.Words.Cloud.Sdk\Api" /E || goto :error

del /S /Q "c:\tmp\php" || goto :error
java -jar codegen\swagger-codegen-cli-2.3.0.jar generate -i spec\asposeforcloud_word.json -l php -t codegen\Templates\php -o c:/tmp/php/ --invoker-package Aspose\Words --model-package Model --api-package Api || goto :error

codegen\Tools\SplitPhpCodeFile.exe C:\tmp\php\SwaggerClient-php\lib\Api\WordsApi.php C:\tmp\php\SwaggerClient-php\lib\Model\Requests\ || goto :error

del /S /Q "SDKs\PHP\src\Aspose\Words\Model" || goto :error
attrib +r +s SDKs\PHP\src\Aspose\Words\RepeatRequestException.php || goto :error
del /S /Q "SDKs\PHP\src\Aspose\Words" || goto :error
attrib -r -s SDKs\PHP\src\Aspose\Words\RepeatRequestException.php || goto :error

xcopy "C:\tmp\php\SwaggerClient-php\lib\Model" "SDKs\PHP\src\Aspose\Words\Model" /E || goto :error
del /S /Q "C:\tmp\php\SwaggerClient-php\lib\Model" || goto :error
rmdir "C:\tmp\php\SwaggerClient-php\lib\Model\Requests" || goto :error
rmdir "C:\tmp\php\SwaggerClient-php\lib\Model" || goto :error
xcopy "C:\tmp\php\SwaggerClient-php\lib\Api" "SDKs\PHP\src\Aspose\Words" /E || goto :error
del /S /Q "C:\tmp\php\SwaggerClient-php\lib\Api" || goto :error
rmdir "C:\tmp\php\SwaggerClient-php\lib\Api" || goto :error
xcopy "C:\tmp\php\SwaggerClient-php\lib" "SDKs\PHP\src\Aspose\Words" /E || goto :error
xcopy /y "C:\tmp\php\SwaggerClient-php\composer.json" "SDKs\PHP" || goto :error


goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%








