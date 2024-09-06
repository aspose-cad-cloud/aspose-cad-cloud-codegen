echo off

SET rootDir=%~dp0

set net_branch="master"
set java_branch="master"
set php_branch="master"
set node_branch="master"
set ruby_branch="master"
set python_branch="master"
set root_branch="master"

echo root dir is set to: %~dp0

cd ../..

echo =========== .NET

cd SDKS/NET
git pull --ff-only origin %drawing_branch%
git checkout %drawing_branch%
cd ../..

echo =========== Java

cd SDKS/Java
git pull --ff-only origin %extensions_external_branch%
git checkout %extensions_external_branch%
cd ../..

echo =========== PHP

cd SDKS/PHP
git pull --ff-only origin %extensions_branch%
git checkout "%extensions_branch%"
cd ../..

echo =========== NODE

cd SDKS/NodeJs
git pull --ff-only origin %draco_branch%
git checkout %draco_branch%
cd ../..

echo =========== PYTHON

cd SDKS/Python
git pull --ff-only origin %core_branch%
git checkout %core_branch%
cd ../..

echo =========== RUBY

cd SDKS/Ruby
git pull --ff-only origin %metered_branch%
git checkout %metered_branch%
cd ../..

echo =========== ROOT
git pull --ff-only origin %root_branch%
git checkout %root_branch%

set /p DUMMY=Hit ENTER to continue...

cd scripts/pre-release