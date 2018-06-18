cd .\codegen

set sdkfolder=..\SDKs\NET

copy /y Templates\csharp\.swagger-codegen-ignore %sdkfolder%\.swagger-codegen-ignore
if exist "%sdkfolder%\src\Aspose.CAD.Cloud.Sdk\Api\" del /S /Q "%sdkfolder%\src\Aspose.CAD.Cloud.Sdk\Api\" || goto :error
if exist "%sdkfolder%\src\Aspose.CAD.Cloud.Sdk\Model\" del /S /Q "%sdkfolder%\src\Aspose.CAD.Cloud.Sdk\Model\" || goto :error
::java -jar Tools\swagger-codegen-cli-2.3.1.jar generate -i http://api-dev.aspose.cloud/v1.1/CAD/swagger/spec -l csharp -t Templates\csharp -o %sdkfolder% -c config.net.json || goto :error
java -jar Tools\swagger-codegen-cli-2.3.1.jar generate -i http://localhost:61290/v1.1/cad/swagger/spec -l csharp -t Templates\csharp -o %sdkfolder% -c config.net.json || goto :error
Tools\RequestModelExtractor.exe %sdkfolder%\src\Aspose.CAD.Cloud.Sdk\Api\ %sdkfolder%\src\Aspose.CAD.Cloud.Sdk\Model\Requests\ csharp || goto :error

cd ..