del /S /Q "c:\tmp\java" || goto :error
java -jar codegen\swagger-codegen-cli-2.3.0.jar generate -i spec\asposeforcloud_cad.json -l java -t codegen\Templates\java -o c:/tmp/java/ -c codegen\javaConfig.json || goto :error

codegen\Tools\SplitJavaCodeFile.exe C:\tmp\java\src\main\java\com\aspose\cad\cloud\api\cadApi.java C:\tmp\java\src\main\java\com\aspose\cad\cloud\model\requests\ || goto :error

del /S /Q "SDKs\Java\src\main\java\com\aspose\cad\cloud\model" || goto :error
del /S /Q "SDKs\Java\src\main\java\com\aspose\cad\cloud\api\CadApi.java" || goto :error
RD /S /Q "C:\tmp\java\src\test" || goto :error

xcopy "C:\tmp\java\src\main\java\com\aspose\cad\cloud" "SDKs\Java\src\main\java\com\aspose\cad\cloud" /E /Y || goto :error
::xcopy "C:\tmp\java\src\main\java\com\aspose\cad\cloud\model" "SDKs\Java\src\main\java\com\aspose\cad\cloud\model" /E || goto :error
::xcopy "C:\tmp\java\src\main\java\com\aspose\cad\cloud\api" "SDKs\Java\src\main\java\com\aspose\cad\cloud\api" /E || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
