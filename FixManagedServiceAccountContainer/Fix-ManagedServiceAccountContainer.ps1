# This script fixes the Managed Service Account container in Active Directory by removing the old well-known object and adding a new one.
# Not my code, use at your own risk.
$DomainDN = (Get-ADDomain).distinguishedName
$TargetOWKOIDString = "1EB93889E40C45DF9F0C64D23BBB6237" # Identifier for wellknown SID. 
$TargetOWKOTemplate = "B:32:$TargetOWKOIDString`:{0}" # String.Format replacable string.
$TargetDN = "CN=Managed Service Accounts,$DomainDN"
 
$OtherWellKnownObjectsOG = (Get-ADObject -filter "objectClass -eq 'domainDns'" -Properties otherwellknownobjects).otherwellknownobjects
$TargetOWKOIndex = $OtherWellKnownObjectsOG.IndexOf( $OtherWellKnownObjectsOG.where({ $PSItem -like "*$TargetOWKOIDString*"})[0])
 
Set-ADObject -Identity $DomainDN -Add @{ 'otherwellknownobjects' = ($TargetOWKOTemplate -f "$TargetDN") } -Remove @{ 'otherwellknownobjects' = $OtherWellKnownObjectsOG[$TargetOWKOIndex] }
 
(Get-ADObject -filter "objectClass -eq 'domainDns'" -Properties otherwellknownobjects).otherwellknownobjects