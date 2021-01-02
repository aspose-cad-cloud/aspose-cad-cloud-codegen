set sdkfolder=.\SDKS\Java
set tmpfolder=c:\tmp\java

del /S /Q "%tmpfolder%" || goto :error
copy /y codegen\Templates\java\.swagger-codegen-ignore %tmpfolder%\.swagger-codegen-ignore
java -jar codegen\swagger-codegen-cli-2.4.5.jar generate -i spec\asposeforcloud_cad_without_disciminator.json -l java --import-mappings JfifData=JfifData -DsupportJava6=true -DdateLibrary=legacy -t codegen\Templates\Java -o %tmpfolder% -c codegen\javaConfig.json || goto :error

codegen\Tools\SplitJavaCodeFile.exe %tmpfolder%\src\main\java\com\aspose\cad\cloud\api\cadApi.java %tmpfolder%\src\main\java\com\aspose\cad\cloud\model\requests\ || goto :error

del /S /Q "SDKs\Java\src\main\java\com\aspose\cad\cloud\model" || goto :error
del /S /Q "SDKs\Java\src\main\java\com\aspose\cad\cloud\api\CadApi.java" || goto :error

xcopy "%tmpfolder%\docs" "SDKs\Java\docs" /E /Y || goto :error
xcopy "%tmpfolder%\src\main\java\com\aspose\cad\cloud\model" "SDKs\Java\src\main\java\com\aspose\cad\cloud\model" /E || goto :error
xcopy "%tmpfolder%\src\main\java\com\aspose\cad\cloud\api" "SDKs\Java\src\main\java\com\aspose\cad\cloud\api" /E || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
