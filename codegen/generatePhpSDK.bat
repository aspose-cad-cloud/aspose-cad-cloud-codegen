set sdkfolder=.\SDKs\PHP
set tmpfolder=c:\tmp\php

del /S /Q "c:\tmp\php" || goto :error
java -jar codegen\swagger-codegen-cli-2.4.5.jar generate -i spec\asposeforcloud_cad_without_disciminator.json -l php -t codegen\Templates\php -o c:/tmp/php/ --invoker-package Aspose\CAD --model-package Model --api-package Api || goto :error

codegen\Tools\SplitPhpCodeFile.exe C:\tmp\php\SwaggerClient-php\lib\Api\CADApi.php C:\tmp\php\SwaggerClient-php\lib\Model\Requests\ || goto :error

del /S /Q "%sdkfolder%\docs" || goto :error
del /S /Q "SDKs\PHP\src\Aspose\CAD\Model" || goto :error
del /S /Q "SDKs\PHP\src\Aspose\CAD\CadApi.php" || goto :error

xcopy "%tmpfolder%\SwaggerClient-php\docs\Api" "%sdkfolder%\docs\" /E || goto :error
xcopy "%tmpfolder%\SwaggerClient-php\docs\Model" "%sdkfolder%\docs\" /E || goto :error
xcopy "%tmpfolder%\SwaggerClient-php\lib\Model" "SDKs\PHP\src\Aspose\CAD\Model" /E || goto :error
del /S /Q "C:\tmp\php\SwaggerClient-php\lib\Model" || goto :error
rmdir "C:\tmp\php\SwaggerClient-php\lib\Model\Requests" || goto :error
rmdir "C:\tmp\php\SwaggerClient-php\lib\Model" || goto :error
xcopy "C:\tmp\php\SwaggerClient-php\lib\Api" "SDKs\PHP\src\Aspose\CAD" /E || goto :error