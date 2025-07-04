# This script will map a network drive in WinPE after prompting for credentials
$credential = Get-Credential
New-PSDrive -Name "O" -PSProvider FileSystem -Root "\\YourFileServer\OSDCloudShare" -Credential $credential -Persist