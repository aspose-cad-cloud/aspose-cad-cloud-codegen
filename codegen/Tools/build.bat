dotnet publish SplitPythonCodeFile\SplitPythonCodeFile.csproj -r win-x64 -f net46 -c Release --self-contained -o .\ /p:CopyOutputSymbolsToPublishDirectory=false
dotnet publish SplitJavaCodeFile\SplitJavaCodeFile.csproj -r win-x64 -f net46 -c Release --self-contained -o .\ /p:CopyOutputSymbolsToPublishDirectory=false
dotnet publish SplitPhpCodeFile\SplitPhpCodeFile.csproj -r win-x64 -f net46 -c Release --self-contained -o .\ /p:CopyOutputSymbolsToPublishDirectory=false
dotnet publish SplitRubyCodeFile\SplitRubyCodeFile.csproj -r win-x64 -f net46 -c Release --self-contained -o .\ /p:CopyOutputSymbolsToPublishDirectory=false
dotnet publish SplitRubyCodeFile\SplitRubyCodeFile.csproj -r win-x64 -f net46 -c Release --self-contained -o .\ /p:CopyOutputSymbolsToPublishDirectory=false
dotnet publish SplitRubyCodeFile\SplitRubyCodeFile.csproj -r win-x64 -f net46 -c Release --self-contained -o .\ /p:CopyOutputSymbolsToPublishDirectory=false
dotnet publish SplitRubyCodeFile\SplitRubyCodeFile.csproj -r win-x64 -f net46 -c Release --self-contained -o .\ /p:CopyOutputSymbolsToPublishDirectory=false
del SplitPythonCodeFile.exe.config
del SplitJavaCodeFile.exe.config
del SplitPhpCodeFile.exe.config
del SplitRubyCodeFile.exe.config
del SplitRubyCodeFile.exe.config
del SplitRubyCodeFile.exe.config
del SplitRubyCodeFile.exe.config
REM  /p:PublishSingleFile=true
REM C:\Windows\Microsoft.NET\Framework64\v4.0.30319\msbuild SplitPythonCodeFile\SplitPythonCodeFile.csproj /p:OutputPath=.\ /p:DebugSymbols=false