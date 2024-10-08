echo OFF
echo "======= NodeJS ======="

set sdkfolder=%~dp0..\SDKs\NodeJs
set rootfolder=%~dp0..\spec
set tmpfolder=c:\tmp\nodejs

copy /y Templates\nodejs\.swagger-codegen-ignore %sdkfolder%\.swagger-codegen-ignore

if exist "%sdkfolder%\lib\api.ts" del /S /Q "%sdkfolder%\lib\api.ts" || goto :error
if exist "%sdkfolder%\lib\model\model.ts" del /S /Q "%sdkfolder%\lib\model\model.ts" || goto :error

java -jar swagger-codegen-cli-2.4.5.jar generate -i "..\spec\asposeforcloud_cad_without_disciminator.json" -l typescript-fetch -t Templates\nodejs -o %tmpfolder% -c nodejsConfig.json || goto :error

if NOT EXIST %sdkfolder%\lib mkdir %sdkfolder%\lib || goto :error
move /y %tmpfolder%\api.ts %sdkfolder%\lib\api.ts || goto :error
move /y %tmpfolder%\git_push.sh %sdkfolder%\lib\model\model.ts || goto :error

move /y %tmpfolder%\configuration.ts %sdkfolder%\lib\internal\request-helper.ts || goto :error

move /y %tmpfolder%\index.ts %sdkfolder%\package.json || goto :error

move /y %tmpfolder%\custom.d.ts %sdkfolder%\README.md || goto :error

cd Tools
powershell -NoProfile -ExecutionPolicy Bypass -Command ". '.\nodejs.ps1' '%sdkfolder%\' '%rootfolder%\asposeforcloud_cad_without_disciminator.json'" || goto :error
cd ..

echo OK
goto :EOF

:error
echo NodeJs generation failed with error #%errorlevel%.
exit /b %errorlevel%
