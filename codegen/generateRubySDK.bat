del /S /Q "c:\tmp\ruby" || goto :error
java -jar codegen\swagger-codegen-cli-2.3.0.jar generate -i spec\asposeforcloud_word.json -l ruby -t codegen\Templates\ruby -o c:/tmp/ruby/ -c codegen\config.json || goto :error

del /S /Q "SDKs\RUBY\lib || goto :error
xcopy "C:\tmp\ruby\lib\swagger_client" "SDKs\RUBY\lib" /E || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
