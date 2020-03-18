del /S /Q "c:\tmp\python" || goto :error
java -jar codegen\swagger-codegen-cli-2.4.5.jar generate -i spec\asposeforcloud_cad_without_disciminator.json -l python -t codegen\Templates\python -c codegen\pythonConfig.json -o c:/tmp/python/ || goto :error

codegen\Tools\SplitPythonCodeFile.exe C:\tmp\python\asposecadcloud\api\cad_api.py C:\tmp\python\asposecadcloud\models\requests\ || goto :error

RD /S /Q "SDKs\python\docs" || goto :error
RD /S /Q "SDKs\python\asposecadcloud" || goto :error
xcopy "C:\tmp\python\docs" "SDKs\python\docs" /E /I || goto :error
xcopy "C:\tmp\python\asposecadcloud" "SDKs\python\asposecadcloud" /E /I || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%

