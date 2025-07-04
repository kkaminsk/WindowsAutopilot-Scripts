Install-Module -Name WindowsAutopilotIntune
Install-Module -Name Microsoft.Graph.Intune
Connect-MgGraph -Scopes "DeviceManagementServiceConfig.Read.All"

# Specify the directory where you want to save the JSON files
$targetDirectory = "C:\AutopilotProfiles"

# Create the directory if it doesn't exist
if (-not (Test-Path -Path $targetDirectory)) {
    New-Item -ItemType Directory -Path $targetDirectory
}

# Get all Autopilot profiles
$autopilotProfiles = Get-AutopilotProfile

# Loop through each profile and export it to a JSON file
foreach ($profile in $autopilotProfiles) {
    $profile | ConvertTo-AutopilotConfigurationJSON | Out-File -FilePath "$targetDirectory\$($profile.displayName).json"
}

Write-Host "Autopilot profiles have been exported to $targetDirectory"