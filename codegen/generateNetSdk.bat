echo OFF
echo "======= .NET ======="

set sdkfolder=..\SDKS\NET
set tmpfolder=c:\tmp\csharp

if exist %tmpfolder% del /S /Q %tmpfolder% || goto :error
if exist "%sdkfolder%\docs\" del /S /Q "%sdkfolder%\docs\" || goto :error

java -jar swagger-codegen-cli-2.4.5.jar generate -i "..\spec\asposeforcloud_cad_without_disciminator.json" -l csharp -t Templates\csharp -o %tmpfolder% -c config.json || goto :error

move "%tmpfolder%\README.md" "%sdkfolder%\docs\API_README.md" || goto :error

Tools\SplitCSharpCodeFile.exe C:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Api\CadApi.cs C:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Model\Requests\ || goto :error

Tools\PostProcessor.exe "..\spec\asposeforcloud_cad.json" "C:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk" || goto :error

if exist "%sdkfolder%\src\Aspose.CAD.Cloud.Sdk\Model" del /S /Q "%sdkfolder%\src\Aspose.CAD.Cloud.Sdk\Model" || goto :error
if exist "%sdkfolder%\src\Aspose.CAD.Cloud.Sdk\Api\CadApi.cs" del /S /Q "%sdkfolder%\src\Aspose.CAD.Cloud.Sdk\Api\CadApi.cs" || goto :error

xcopy "%tmpfolder%\docs" "%sdkfolder%\docs" /E /Y || goto :error
xcopy "%tmpfolder%\src\Aspose.CAD.Cloud.Sdk\Model" "%sdkfolder%\src\Aspose.CAD.Cloud.Sdk\Model" /E /Y || goto :error
xcopy "%tmpfolder%\src\Aspose.CAD.Cloud.Sdk\Api" "%sdkfolder%\src\Aspose.CAD.Cloud.Sdk\Api" /E /Y || goto :error

xcopy "%tmpfolder%\src\Aspose.CAD.Cloud.Sdk\Aspose.CAD.Cloud.Sdk.csproj" "%sdkfolder%\src\Aspose.CAD.Cloud.Sdk\Aspose.CAD.Cloud.Sdk.csproj" /E /Y || goto :error
xcopy "%tmpfolder%\src\Aspose.CAD.Cloud.Sdk\Aspose.CAD.Cloud.Sdk.nuspec" "%sdkfolder%\Aspose.CAD.Cloud.Sdk.nuspec" /E /Y || goto :error