del /S /Q "c:\tmp\python" || goto :error
java -jar codegen\swagger-codegen-cli-2.3.0.jar generate -i spec\asposeforcloud_word.json -l python -t codegen\Templates\python -c codegen\pythonConfig.json -o c:/tmp/python/ || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
