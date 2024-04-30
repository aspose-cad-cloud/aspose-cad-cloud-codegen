echo OFF
echo "======= PYTHON ======="

set sdkfolder=..\SDKs\Python
set tmpfolder=c:\tmp\python

if exist %tmpfolder% del /S /Q "%tmpfolder%" || goto :error
java -jar swagger-codegen-cli-2.4.5.jar generate -i ..\spec\asposeforcloud_cad_without_disciminator.json -l python -t Templates\python -c pythonConfig.json -o %tmpfolder% || goto :error

Tools\SplitPythonCodeFile.exe %tmpfolder%\asposecadcloud\api\cad_api.py %tmpfolder%\asposecadcloud\models\requests\ || goto :error

RD /S /Q "%sdkfolder%\docs" || goto :error
RD /S /Q "%sdkfolder%\asposecadcloud" || goto :error
xcopy "%tmpfolder%\docs" "%sdkfolder%\docs" /E /I /Y || goto :error
xcopy "%tmpfolder%\asposecadcloud" "%sdkfolder%\asposecadcloud" /E /I /Y || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%

