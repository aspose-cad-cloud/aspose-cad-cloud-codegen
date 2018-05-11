del /S /Q "SDKs\NET\Aspose.Words.Cloud.Sdk.BddTests\Features" || goto :error
xcopy "test\bdd\Features" "SDKs\NET\Aspose.Words.Cloud.Sdk.BddTests\Features" /E || goto :error
xcopy "test\TestData" "SDKs\NET\TestData" /E /y || goto :error

del /S /Q "SDKs\node\bdd\features" || goto :error
xcopy "test\bdd\Features" "SDKs\node\bdd\features" /E || goto :error
xcopy "test\TestData" "SDKs\node\TestData" /E /y || goto :error

del /S /Q "SDKs\PHP\bdd\features" || goto :error
xcopy "test\bdd\Features" "SDKs\PHP\bdd\features" /E || goto :error
xcopy "test\TestData" "SDKs\PHP\TestData" /E /y || goto :error

goto :EOF
:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%