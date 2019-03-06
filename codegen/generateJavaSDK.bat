del /S /Q "c:\tmp\java" || goto :error
java -jar codegen\swagger-codegen-cli-2.3.0.jar generate -i spec\asposeforcloud_word.json -l java -t codegen\Templates\java -o c:/tmp/java/ -c codegen\javaConfig.json || goto :error

codegen\Tools\SplitJavaCodeFile.exe C:\tmp\java\src\main\java\com\aspose\words\cloud\api\WordsApi.java C:\tmp\java\src\main\java\com\aspose\words\cloud\model\requests\ || goto :error

del /S /Q "SDKs\java\src\main\java\com\aspose\words\model" || goto :error
del /S /Q "SDKs\java\src\main\java\com\aspose\words\api\WordsApi.java" || goto :error
RD /S /Q "C:\tmp\java\src\test" || goto :error


xcopy "C:\tmp\java\src\main\java\com\aspose\words\cloud\model" "SDKs\java\src\main\java\com\aspose\words\model" /E || goto :error
xcopy "C:\tmp\java\src\main\java\com\aspose\words\cloud\api" "SDKs\java\src\main\java\com\aspose\words\api" /E || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
