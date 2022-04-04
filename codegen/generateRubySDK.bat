echo OFF
echo "======= RUBY ======="

set sdkfolder=..\SDKs\Ruby
set tmpfolder=c:\tmp\ruby

if exist %tmpfolder% del /S /Q "%tmpfolder%" || goto :error
java -jar swagger-codegen-cli-2.3.0.jar generate -i ..\spec\asposeforcloud_cad_without_disciminator.json -l ruby -t Templates\ruby -o %tmpfolder% -c rubyConfig.json || goto :error

Tools\SplitRubyCodeFile.exe %tmpfolder%\lib\aspose_cad_cloud\api\cad_api.rb %tmpfolder%\lib\aspose_cad_cloud\models\requests\ || goto :error

del /S /Q "%sdkfolder%\lib" || goto :error
xcopy "%tmpfolder%\lib" "%sdkfolder%\lib\" /E /Y || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
