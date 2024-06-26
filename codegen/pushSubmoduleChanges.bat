set curpath=%cd%

cd %1
git diff --name-status || goto :error
git add -A || goto :error
git commit -a -m "SDK regenerated by CI server" || exit /b 0
git diff --name-status || goto :error
git diff origin/master..HEAD --name-status || goto :error
git push %2 HEAD:master || goto :error

goto :EOF

:error
cd %curpath%
echo Failed with git error #%errorlevel%.
exit /b 1
