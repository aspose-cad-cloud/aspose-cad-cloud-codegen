del /S /Q "c:\tmp\python" || goto :error
java -jar codegen\swagger-codegen-cli-2.3.0.jar generate -i spec\asposeforcloud_word_without_disciminator.json -l python -t codegen\Templates\python -c codegen\pythonConfig.json -o c:/tmp/python/ || goto :error

codegen\Tools\SplitPythonCodeFile.exe C:\tmp\python\asposewordscloud\apis\words_api.py C:\tmp\python\asposewordscloud\models\requests\ || goto :error

RD /S /Q "SDKs\python\docs" || goto :error
RD /S /Q "SDKs\python\asposewordscloud" || goto :error
xcopy "C:\tmp\python\docs" "SDKs\python\docs" /E /I || goto :error
xcopy "C:\tmp\python\asposewordscloud" "SDKs\python\asposewordscloud" /E /I || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%

