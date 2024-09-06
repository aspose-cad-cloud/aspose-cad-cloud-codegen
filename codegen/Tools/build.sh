#!/bin/bash

# Publish commands for Linux
dotnet publish PostProcessor/PostProcessor.csproj -r linux-x64 -f netcoreapp3.1 -c Release
dotnet publish SplitPythonCodeFile/SplitPythonCodeFile.csproj -r linux-x64 -f netcoreapp3.1 -c Release
dotnet publish SplitJavaCodeFile/SplitJavaCodeFile.csproj -r linux-x64 -f netcoreapp3.1 -c Release
dotnet publish SplitPhpCodeFile/SplitPhpCodeFile.csproj -r linux-x64 -f netcoreapp3.1 -c Release
dotnet publish SplitRubyCodeFile/SplitRubyCodeFile.csproj -r linux-x64 -f netcoreapp3.1 -c Release
dotnet publish SplitCSharpCodeFile/SplitCSharpCodeFile.csproj -r linux-x64 -f netcoreapp3.1 -c Release