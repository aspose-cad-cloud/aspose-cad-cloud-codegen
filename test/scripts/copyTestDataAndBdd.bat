del /S /Q "SDKs\NET\Aspose.Words.Cloud.Sdk.BddTests\Features" || goto :error
xcopy "test\bdd\Features" "SDKs\NET\Aspose.Words.Cloud.Sdk.BddTests\Features" /E || goto :error
xcopy "test\TestData" "SDKs\NET\TestData" /E /y || goto :error

del /S /Q "SDKs\node\bdd\features" || goto :error
xcopy "test\bdd\Features" "SDKs\node\bdd\features" /E || goto :error
xcopy "test\TestData" "SDKs\node\TestData" /E /y || goto :error

del /S /Q "SDKs\PHP\features\conversion" || goto :error
del /S /Q "SDKs\PHP\features\mailMerge" || goto :error
xcopy "test\bdd\Features" "SDKs\PHP\features" /E || goto :error
xcopy "test\TestData" "SDKs\PHP\TestData" /E /y || goto :error

goto :EOF
:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%