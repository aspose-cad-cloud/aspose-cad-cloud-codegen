cd .\codegen

set sdkfolder=..\SDKs\Java

copy /y Templates\java\.swagger-codegen-ignore %sdkfolder%\.swagger-codegen-ignore
if exist "%sdkfolder%\src\main\java\com\aspose\cad\cloud\sdk\api\" del /S /Q "%sdkfolder%\src\main\java\com\aspose\cad\cloud\sdk\api\" || goto :error
if exist "%sdkfolder%\src\main\java\com\aspose\cad\cloud\sdk\model\" del /S /Q "%sdkfolder%\src\main\java\com\aspose\cad\cloud\sdk\model\" || goto :error
java -jar Tools\swagger-codegen-cli-2.3.1.jar generate -i http://localhost:61290/v1.1/cad/swagger/spec -l java -t Templates\Java -o %sdkfolder% -c config.java.json || goto :error
::java -jar Tools\swagger-codegen-cli-2.3.1.jar generate -i http://api-dev.aspose.cloud/v1.1/cad/swagger/spec -l java -t Templates\Java -o %sdkfolder% -c config.java.json || goto :error
Tools\RequestModelExtractor.exe %sdkfolder%\src\main\java\com\aspose\cad\cloud\sdk\api\ %sdkfolder%\src\main\java\com\aspose\cad\cloud\sdk\model\requests\ java || goto :error
if exist "%sdkfolder%\src\test\java\com\aspose\cad\cloud\sdk" rmdir /S /Q "%sdkfolder%\src\test\java\com\aspose\cad\cloud\sdk" || goto :error
if exist "%sdkfolder%\src\main\java\com\aspose\cad\cloud\sdk\invoker\auth\" rmdir /S /Q "%sdkfolder%\src\main\java\com\aspose\cad\cloud\sdk\invoker\auth\" || goto :error
if exist "%sdkfolder%\gradle\" rmdir /S /Q "%sdkfolder%\gradle\" || goto :error

cd ..