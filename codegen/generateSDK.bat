::powershell -Command Invoke-WebRequest -OutFile spec\asposeforcloud_cad.json https://localhost:44350/v3.0/cad/swagger/sdkspec
::powershell -Command Invoke-WebRequest -OutFile spec\asposeforcloud_cad.json https://api-qa.aspose.cloud/v3.0/cad/swagger/sdkspec
::powershell -Command Invoke-WebRequest -OutFile spec\asposeforcloud_cad_without_disciminator.json https://api-qa.aspose.cloud/v3.0/cad/swagger/sdkspec

::call codegen\generateNodeJsSDK ||  goto :error
::call codegen\generateNetSDK ||  goto :error
call codegen\generatePhpSDK ||  goto :error
::call codegen\generateRubySDK ||  goto :error
::call codegen\generatePythonSDK||  goto :error
::call codegen\generateJavaSDK || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%








