set sdkfolder=SDKS\NET
set tmpfolder=c:\tmp\csharp

del /S /Q %tmpfolder% || goto :error
if exist "%sdkfolder%\docs\" del /S /Q "%sdkfolder%\docs\" || goto :error
java -jar codegen\swagger-codegen-cli-2.3.0.jar generate -i spec\asposeforcloud_cad_without_disciminator.json -l csharp -t codegen\Templates\csharp -o %tmpfolder% -c codegen\config.json || goto :error
move %tmpfolder%\README.md %sdkfolder%\docs\API_README.md || goto :error

codegen\Tools\SplitCSharpCodeFile.exe C:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Api\CadApi.cs C:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Model\Requests\ || goto :error
codegen\Tools\PostProcessor.exe "spec\asposeforcloud_cad.json" "C:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk" || goto :error

del /S /Q "%sdkfolder%\src\Aspose.CAD.Cloud.Sdk\Model" || goto :error
del /S /Q "%sdkfolder%\src\Aspose.CAD.Cloud.Sdk\Api\CadApi.cs" || goto :error

xcopy "%tmpfolder%\docs" "%sdkfolder%\docs" /E || goto :error
xcopy "%tmpfolder%\src\Aspose.CAD.Cloud.Sdk\Model" "%sdkfolder%\src\Aspose.CAD.Cloud.Sdk\Model" /E || goto :error
xcopy "%tmpfolder%\src\Aspose.CAD.Cloud.Sdk\Api" "%sdkfolder%\src\Aspose.CAD.Cloud.Sdk\Api" /E || goto :error