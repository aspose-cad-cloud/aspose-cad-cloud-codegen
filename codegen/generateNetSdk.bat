del /S /Q "c:\tmp\csharp"
cd ..
java -jar codegen\swagger-codegen-cli-2.3.0.jar generate -i spec\asposeforcloud_CAD.json -l csharp -t codegen\Templates\csharp -o c:/tmp/csharp/ -c codegen\config.json || goto :error

codegen\Tools\SplitCSharpCodeFile.exe C:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Api\PropertiesApi.cs C:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Model\Requests\ || goto :error
codegen\Tools\SplitCSharpCodeFile.exe C:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Api\RotateFlipApi.cs C:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Model\Requests\ || goto :error
codegen\Tools\SplitCSharpCodeFile.exe C:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Api\ResizeApi.cs C:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Model\Requests\ || goto :error
codegen\Tools\SplitCSharpCodeFile.exe C:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Api\SaveAsApi.cs C:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Model\Requests\ || goto :error

del /S /Q "SDKs\NET\Aspose.CAD.Cloud.Sdk\Model"
del /S /Q "SDKs\NET\Aspose.CAD.Cloud.Sdk\Api"

xcopy "c:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Model\*" "SDKs\NET\Aspose.CAD.Cloud.Sdk\Model" /E || goto :error
xcopy "c:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Api\*" "SDKs\NET\Aspose.CAD.Cloud.Sdk\Api" /E || goto :error

:error
cd codegen