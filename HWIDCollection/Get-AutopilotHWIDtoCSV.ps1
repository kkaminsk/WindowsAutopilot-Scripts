# Prereqs
Install-Script -Name Get-WindowsAutoPilotInfo

# Extract the hardware ID
$outputfile = "\AutopilotHardwareID-" + $env:COMPUTERNAME + ".csv" 
$outputpath = $env:TEMP + $Outputfile
Get-WindowsAutoPilotInfo.ps1 -OutputFile $outputpath

#Run this if you want to see the contents of the file
notepad.exe $outputpath