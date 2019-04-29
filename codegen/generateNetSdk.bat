del /S /Q "c:\tmp\csharp" || goto :error
java -jar codegen\swagger-codegen-cli-2.3.0.jar generate -i spec\asposeforcloud_cad.json -l csharp -t codegen\Templates\csharp -o c:/tmp/csharp/ -c codegen\config.json || goto :error

codegen\Tools\SplitCSharpCodeFile.exe C:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Api\CADApi.cs C:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Model\Requests\ || goto :error

del /S /Q "SDKs\NET\src\Aspose.CAD.Cloud.Sdk\Model" || goto :error
del /S /Q "SDKs\NET\src\Aspose.CAD.Cloud.Sdk\Api\CADApi.cs" || goto :error

xcopy "c:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Model" "SDKs\NET\src\Aspose.CAD.Cloud.Sdk\Model" /E || goto :error
xcopy "c:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Api" "SDKs\NET\src\Aspose.CAD.Cloud.Sdk\Api" /E || goto :error