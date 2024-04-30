::powershell -Command Invoke-WebRequest -OutFile spec\asposeforcloud_cad.json https://localhost:44350/v3.0/cad/swagger/sdkspec
powershell -Command Invoke-WebRequest -OutFile ..\spec\asposeforcloud_cad.json https://api.aspose.cloud/v3.0/cad/swagger/spec
powershell -Command Invoke-WebRequest -OutFile ..\spec\asposeforcloud_cad_without_disciminator.json https://api.aspose.cloud/v3.0/cad/swagger/sdkspec

exit /b 1

REM powershell -Command Invoke-WebRequest -OutFile ..\spec\asposeforcloud_cad.json https://localhost:5003/v3.0/cad/swagger/spec
REM powershell -Command Invoke-WebRequest -OutFile ..\spec\asposeforcloud_cad_without_disciminator.json https://localhost:5003/v3.0/cad/swagger/sdkspec

call generateNodeJsSDK ||  goto :error
call generateNetSDK ||  goto :error
call generatePhpSDK ||  goto :error
call generateRubySDK ||  goto :error
call generatePythonSDK||  goto :error
call generateJavaSDK || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%

:EOF
