del /S /Q "c:\tmp\python" || goto :error
java -jar codegen\swagger-codegen-cli-2.3.0.jar generate -i spec\asposeforcloud_word_python.json -l python -t codegen\Templates\python -c codegen\pythonConfig.json -o c:/tmp/python/ || goto :error

codegen\Tools\SplitPythonCodeFile.exe C:\tmp\python\asposewordscloud\apis\words_api.py C:\tmp\python\asposewordscloud\models\requests\ || goto :error

del /S /Q "SDKs\python\docs" || goto :error
del /S /Q "SDKs\python\asposewordscloud" || goto :error
xcopy "C:\tmp\python\docs" "SDKs\python\docs" /E || goto :error
xcopy "C:\tmp\python\asposewordscloud" "SDKs\python\asposewordscloud" /E || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
