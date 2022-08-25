param(
    [string[]]$needs,
    [string[]]$environments,
    [string]$github_environment

)

$Jobs = @()
$environments_succession = $environments

for ($i = 0; $i -lt $environments_succession.Length; $i++) {
    $environment = $environments_succession[$i]

    $environment_needs = $needs
    if ($i -ne 0) {
        $environment_needs += $environments_succession[$i - 1]
    }

    $Jobs += @{
        job_name    = "Deploy-$environment"
        needs       = "[$($environment_needs -join ",")]"
        environment = "$github_environment"
    }
}
Write-Host $($Jobs | ConvertTo-JSON)
Write-Host "::set-output name=matrix::$($Jobs | ConvertTo-JSON -Compress))"

# $Jobs = @()



# @('dev', 'test') | ForEach-Object {
# $Jobs += @{
#     job_name = "Run $_ jobs"
#     os = $_
#     command = "$_ command"
# }
# }
# Write-Host "::set-output name=matrix::$($Jobs | ConvertTo-JSON -Compress))"