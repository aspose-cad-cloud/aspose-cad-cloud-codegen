del /S /Q "c:\tmp\ruby" || goto :error
java -jar codegen\swagger-codegen-cli-2.3.0.jar generate -i spec\asposeforcloud_cad.json -l ruby -t codegen\Templates\ruby -o c:/tmp/ruby/ -c codegen\rubyConfig.json || goto :error

codegen\Tools\SplitRubyCodeFile.exe C:\tmp\ruby\lib\aspose_cad_cloud\api\cad_api.rb C:\tmp\ruby\lib\aspose_cad_cloud\models\requests\ || goto :error

del /S /Q "SDKs\RUBY\lib" || goto :error
xcopy "C:\tmp\ruby\lib" "SDKs\Ruby\lib" /E || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
