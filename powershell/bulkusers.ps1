import-csv .\bulkusers.csv | foreach-object {$UPN = $_.SamAccountName + "@testlab.com" 
New-ADUser -SamAccountName $_.SamAccountName -UserPrincipalName $UPN -Name $_.name -DisplayName $_.name -Path $_.path 
-AccountPassword (ConvertTo-SecureString "p@ssw0rd" -AsPlainText -force) -Enabled $True -PassThru}
