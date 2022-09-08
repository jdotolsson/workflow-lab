[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $WorkingDirectory
)

Set-Location $WorkingDirectory

$schemaFile = "./schema.json"
$configFiles = (Get-ChildItem -Filter *.json -Recurse | Select-Object -Expand FullName) -join ","
& "./Automotive.JsonSchemaValidator.exe" $configFiles $schemaFile