del /S /Q "c:\tmp\swift" || goto :error
java -jar codegen\swagger-codegen-cli-2.3.0.jar generate -i spec\asposeforcloud_word_without_disciminator.json -l swift4 -t codegen\Templates\swift4 -o c:/tmp/swift/ -c codegen\swiftConfig.json || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
