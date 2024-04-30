echo OFF
echo "======= PHP ======="

set sdkfolder=..\SDKs\PHP
set tmpfolder=C:\tmp\PHP

if exist %tmpfolder% del /S /Q "%tmpfolder%" || goto :error
java -jar swagger-codegen-cli-2.4.5.jar generate -i ..\spec\asposeforcloud_cad_without_disciminator.json -l php -t Templates\php -o "%tmpfolder%" --invoker-package Aspose\CAD --model-package Model --api-package Api || goto :error

Tools\SplitPhpCodeFile.exe %tmpfolder%\SwaggerClient-php\lib\Api\CADApi.php %tmpfolder%\SwaggerClient-php\lib\Model\Requests\ || goto :error

if exist "%sdkfolder%\docs" del /S /Q "%sdkfolder%\docs" || goto :error
if exist "%sdkfolder%\src\Aspose\CAD\Model" del /S /Q "%sdkfolder%\src\Aspose\CAD\Model" || goto :error
if exist "%sdkfolder%\src\Aspose\CAD\CadApi.php" del /S /Q "%sdkfolder%\src\Aspose\CAD\CadApi.php" || goto :error

xcopy "%tmpfolder%\SwaggerClient-php\docs\Api" "%sdkfolder%\docs\" /E || goto :error
xcopy "%tmpfolder%\SwaggerClient-php\docs\Model" "%sdkfolder%\docs\" /E || goto :error
xcopy "%tmpfolder%\SwaggerClient-php\lib\Model" "%sdkfolder%\src\Aspose\CAD\Model" /E || goto :error
del /S /Q "%tmpfolder%\SwaggerClient-php\lib\Model" || goto :error
rmdir "%tmpfolder%\SwaggerClient-php\lib\Model\Requests" || goto :error
rmdir "%tmpfolder%\SwaggerClient-php\lib\Model" || goto :error
xcopy "%tmpfolder%\SwaggerClient-php\lib\Api" "%sdkfolder%\src\Aspose\CAD" /E || goto :error