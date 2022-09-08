[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $WorkingDirectory
)

Set-Location $WorkingDirectory

$schemaFile = Get-ChildItem "./schema.json" | Select-Object -Expand FullName
$configFiles = (Get-ChildItem -Filter config.json -Recurse | Select-Object -Expand FullName) -join ","
& "./Automotive.JsonSchemaValidator.exe" $configFiles $schemaFile