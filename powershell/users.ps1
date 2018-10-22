function Usr-Search {
# Search for names matching last name. Returns the Sam Account Name
$SearchName = Read-Host "Enter last name to search: "
Get-ADUser -LDAPFilter "(name=*$SearchName*)" -SearchBase 'OU=,OU=,OU=,DC=,DC=,DC=,DC=' -properties Name,SamAccountName | select SamAccountName, Enabled | Format-Table
}

function Usr-Disable {
$UsrDis = Read-Host "Enter Sam Account Name to disable: "
$DisableDescription = Read-host "Enter disable reason, date, and initials: "
Set-ADUser $UsrDis -Enabled $false -Description ($_.Description + $DisableDescription)
}

clear
Write-Host "Select <1> to search for user(s), <2> to disable user(s). Use <q> to quit script."
do {
$selection = Read-Host "Make a selection: "
if ($selection -eq 1)
{
 Usr-Search
}
elseif ($selection -eq 2) {
 Usr-Disable
}
}
until ($selection -ne 'q') 
