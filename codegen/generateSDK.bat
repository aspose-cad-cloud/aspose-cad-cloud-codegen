::powershell -Command Invoke-WebRequest -OutFile spec\asposeforcloud_cad.json https://localhost:44350/v3.0/cad/swagger/sdkspec
::powershell -Command Invoke-WebRequest -OutFile ..\spec\asposeforcloud_cad.json https://api.aspose.cloud/v3.0/cad/swagger/spec
::powershell -Command Invoke-WebRequest -OutFile ..\spec\asposeforcloud_cad_without_disciminator.json https://api.aspose.cloud/v3.0/cad/swagger/sdkspec

REM powershell -Command Invoke-WebRequest -OutFile ..\spec\asposeforcloud_cad.json https://localhost:5003/v3.0/cad/swagger/spec
REM powershell -Command Invoke-WebRequest -OutFile ..\spec\asposeforcloud_cad_without_disciminator.json https://localhost:5003/v3.0/cad/swagger/sdkspec

set "PatchVersion=24.5.2"

echo "Update Java package version"
powerShell -Command "$json = Get-Content -Path 'javaConfig.json' | ConvertFrom-Json; $json.artifactVersion = '%PatchVersion%'; $json | ConvertTo-Json -Depth 32 | Set-Content -Path 'javaConfig.json'"

echo "Update .NET package version"
powerShell -Command "$json = Get-Content -Path 'config.json' | ConvertFrom-Json; $json.packageVersion = '%PatchVersion%'; $json | ConvertTo-Json -Depth 32 | Set-Content -Path 'config.json'"

echo "Update NodeJs package version"
powerShell -Command "$json = Get-Content -Path 'nodejsConfig.json' | ConvertFrom-Json; $json.npmVersion = '%PatchVersion%'; $json | ConvertTo-Json -Depth 32 | Set-Content -Path 'nodejsConfig.json'"

echo "Update PHP package version"
powerShell -Command "$json = Get-Content -Path 'phpConfig.json' | ConvertFrom-Json; $json.artifactVersion = '%PatchVersion%'; $json | ConvertTo-Json -Depth 32 | Set-Content -Path 'phpConfig.json'"

echo "Update Python package version"
powerShell -Command "$json = Get-Content -Path 'pythonConfig.json' | ConvertFrom-Json; $json.packageVersion = '%PatchVersion%'; $json | ConvertTo-Json -Depth 32 | Set-Content -Path 'pythonConfig.json'"

echo "Update Ruby package version"
powerShell -Command "$json = Get-Content -Path 'rubyConfig.json' | ConvertFrom-Json; $json.gemVersion = '%PatchVersion%'; $json | ConvertTo-Json -Depth 32 | Set-Content -Path 'rubyConfig.json'"

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
