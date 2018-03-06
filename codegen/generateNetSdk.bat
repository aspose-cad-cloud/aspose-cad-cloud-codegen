del /S /Q "c:\tmp\csharp" || goto :error
java -jar codegen\swagger-codegen-cli-2.3.0.jar generate -i spec\asposeforcloud_word.json -l csharp -t codegen\Templates\csharp -o c:/tmp/csharp/ -c codegen\config.json || goto :error

codegen\Tools\SplitCSharpCodeFile.exe C:\tmp\csharp\src\Aspose.Words.Cloud.Sdk\Api\WordsApi.cs C:\tmp\csharp\src\Aspose.Words.Cloud.Sdk\Model\Requests\ || goto :error

del /S /Q "SDKs\NET\Aspose.Words.Cloud.Sdk\Model" || goto :error
del /S /Q "SDKs\NET\Aspose.Words.Cloud.Sdk\Api\WordsApi.cs" || goto :error

xcopy "c:\tmp\csharp\src\Aspose.Words.Cloud.Sdk\Model" "SDKs\NET\Aspose.Words.Cloud.Sdk\Model" /E || goto :error
xcopy "c:\tmp\csharp\src\Aspose.Words.Cloud.Sdk\Api" "SDKs\NET\Aspose.Words.Cloud.Sdk\Api" /E || goto :error