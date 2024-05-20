dotnet publish PostProcessor\PostProcessor.csproj -r win-x64 -f netcoreapp3.1 -c Release -o .\ /p:PublishTrimmed=false /p:PublishSingleFile=true /p:CopyOutputSymbolsToPublishDirectory=false --self-contained false
dotnet publish SplitPythonCodeFile\SplitPythonCodeFile.csproj -r win-x64 -f netcoreapp3.1 -c Release -o .\ /p:PublishTrimmed=false /p:PublishSingleFile=true /p:CopyOutputSymbolsToPublishDirectory=false --self-contained false
dotnet publish SplitJavaCodeFile\SplitJavaCodeFile.csproj -r win-x64 -f netcoreapp3.1 -c Release -o .\ /p:PublishTrimmed=false /p:PublishSingleFile=true /p:CopyOutputSymbolsToPublishDirectory=false --self-contained false
dotnet publish SplitPhpCodeFile\SplitPhpCodeFile.csproj -r win-x64 -f netcoreapp3.1 -c Release -o .\ /p:PublishTrimmed=false /p:PublishSingleFile=true /p:CopyOutputSymbolsToPublishDirectory=false --self-contained false
dotnet publish SplitRubyCodeFile\SplitRubyCodeFile.csproj -r win-x64 -f netcoreapp3.1 -c Release -o .\ /p:PublishTrimmed=false /p:PublishSingleFile=true /p:CopyOutputSymbolsToPublishDirectory=false --self-contained false
dotnet publish SplitCSharpCodeFile\SplitCSharpCodeFile.csproj -r win-x64 -f netcoreapp3.1 -c Release -o .\ /p:PublishTrimmed=false /p:PublishSingleFile=true /p:CopyOutputSymbolsToPublishDirectory=false --self-contained false
::dotnet publish SplitRubyCodeFile\SplitRubyCodeFile.csproj -r win-x64 -f netcoreapp3.1 -c Release -o .\ /p:PublishTrimmed=false /p:PublishSingleFile=true /p:CopyOutputSymbolsToPublishDirectory=false --self-contained false
::dotnet publish SplitRubyCodeFile\SplitRubyCodeFile.csproj -r win-x64 -f netcoreapp3.1 -c Release -o .\ /p:PublishTrimmed=false /p:PublishSingleFile=true /p:CopyOutputSymbolsToPublishDirectory=false --self-contained false
dotnet publish SplitRubyCodeFile\SplitRubyCodeFile.csproj -r win-x64 -f netcoreapp3.1 -c Release -o .\ /p:PublishTrimmed=false /p:PublishSingleFile=true /p:CopyOutputSymbolsToPublishDirectory=false --self-contained false
dotnet publish SplitRubyCodeFile\SplitRubyCodeFile.csproj -r win-x64 -f netcoreapp3.1 -c Release -o .\ /p:PublishTrimmed=false /p:PublishSingleFile=true /p:CopyOutputSymbolsToPublishDirectory=false --self-contained false
dotnet publish SplitRubyCodeFile\SplitRubyCodeFile.csproj -r win-x64 -f netcoreapp3.1 -c Release -o .\ /p:PublishTrimmed=false /p:PublishSingleFile=true /p:CopyOutputSymbolsToPublishDirectory=false --self-contained false
del SplitPythonCodeFile.exe.config
del SplitJavaCodeFile.exe.config
del SplitPhpCodeFile.exe.config
del SplitRubyCodeFile.exe.config
del SplitCSharpCodeFile.exe.config
::del SplitRubyCodeFile.exe.config
::del SplitRubyCodeFile.exe.config
REM  /p:PublishSingleFile=true
REM C:\Windows\Microsoft.NET\Framework64\v4.0.30319\msbuild SplitPythonCodeFile\SplitPythonCodeFile.csproj /p:OutputPath=.\ /p:DebugSymbols=false