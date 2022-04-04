echo OFF
echo "======= JAVA ======="

set sdkfolder=..\SDKS\Java
set tmpfolder=c:\tmp\java

if exist %tmpfolder% del /S /Q "%tmpfolder%" || goto :error
copy /y Templates\java\.swagger-codegen-ignore %tmpfolder%\.swagger-codegen-ignore
java -jar swagger-codegen-cli-2.4.5.jar generate -i ..\spec\asposeforcloud_cad_without_disciminator.json -l java --import-mappings JfifData=JfifData -DsupportJava6=true -DdateLibrary=legacy -t Templates\Java -o %tmpfolder% -c javaConfig.json || goto :error

Tools\SplitJavaCodeFile.exe %tmpfolder%\src\main\java\com\aspose\cad\cloud\api\cadApi.java %tmpfolder%\src\main\java\com\aspose\cad\cloud\model\requests\ || goto :error

if exist "%sdkfolder%\src\main\java\com\aspose\cad\cloud\model" del /S /Q "%sdkfolder%\src\main\java\com\aspose\cad\cloud\model" || goto :error
if exist "%sdkfolder%\src\main\java\com\aspose\cad\cloud\api\CadApi.java" del /S /Q "%sdkfolder%\src\main\java\com\aspose\cad\cloud\api\CadApi.java" || goto :error

xcopy "%tmpfolder%\docs" "%sdkfolder%\docs" /E /Y || goto :error
xcopy "%tmpfolder%\src\main\java\com\aspose\cad\cloud\model" "%sdkfolder%\src\main\java\com\aspose\cad\cloud\model" /E /Y || goto :error
xcopy "%tmpfolder%\src\main\java\com\aspose\cad\cloud\api" "%sdkfolder%\src\main\java\com\aspose\cad\cloud\api" /E /Y || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
