param([string]$pathToSdk, [string]$pathToSpecFile)

$lines = Get-Content -encoding UTF8 $pathToSdk\lib\api.ts 
$jsonSpec = Get-Content -encoding UTF8 $pathToSpecFile | Out-String | ConvertFrom-Json

# Generate Doc

Import-Module ./PSNodejsCodeGenerator.psm1
Import-Module ./PSCoreCodeGenerator.psm1

Update-Doc