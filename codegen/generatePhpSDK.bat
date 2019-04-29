del /S /Q "c:\tmp\php" || goto :error
java -jar codegen\swagger-codegen-cli-2.3.0.jar generate -i spec\asposeforcloud_cad.json -l php -t codegen\Templates\php -o c:/tmp/php/ --invoker-package Aspose\CAD --model-package Model --api-package Api || goto :error

codegen\Tools\SplitPhpCodeFile.exe C:\tmp\php\SwaggerClient-php\lib\Api\CADApi.php C:\tmp\php\SwaggerClient-php\lib\Model\Requests\ || goto :error

del /S /Q "SDKs\PHP\src\Aspose\CAD\Model" || goto :error
attrib +r +s SDKs\PHP\src\Aspose\CAD\RepeatRequestException.php || goto :error
del /S /Q "SDKs\PHP\src\Aspose\CAD" || goto :error
attrib -r -s SDKs\PHP\src\Aspose\CAD\RepeatRequestException.php || goto :error

xcopy "C:\tmp\php\SwaggerClient-php\lib\Model" "SDKs\PHP\src\Aspose\CAD\Model" /E || goto :error
del /S /Q "C:\tmp\php\SwaggerClient-php\lib\Model" || goto :error
rmdir "C:\tmp\php\SwaggerClient-php\lib\Model\Requests" || goto :error
rmdir "C:\tmp\php\SwaggerClient-php\lib\Model" || goto :error
xcopy "C:\tmp\php\SwaggerClient-php\lib\Api" "SDKs\PHP\src\Aspose\CAD" /E || goto :error
del /S /Q "C:\tmp\php\SwaggerClient-php\lib\Api" || goto :error
rmdir "C:\tmp\php\SwaggerClient-php\lib\Api" || goto :error
xcopy "C:\tmp\php\SwaggerClient-php\lib" "SDKs\PHP\src\Aspose\CAD" /E || goto :error
xcopy /y "C:\tmp\php\SwaggerClient-php\composer.json" "SDKs\PHP" || goto :error