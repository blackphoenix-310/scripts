$usr = $env:username
$src = "C:\Users\$usr"
$dest = "H:\local_archive\$usr"
$outlook = "C:\Users\$usr\AppData\Local\Microsoft\Outlook"
$firefox = "C:\Users\$usr\AppData\Roaming\Mozilla\Firefox"
$client_kill = Stop-Process -Name OUTLOOK* -Force; Stop-Process -Name firefox -Force
$exclude = @('AppData', '*.lck')

$client_kill

if(!(Test-Path -Path $dest)) {
New-Item -ItemType directory -Path "H:\local_archive\$usr"
Get-ChildItem -Path $src -Exclude $exclude | Copy-Item -Destination $dest -Recurse -Force
Copy-Item $outlook -Destination $dest -recurse -Force
Copy-Item $firefox -Destination $dest -recurse -Force
}
elseif(Test-Path -Path $dest) {
Get-ChildItem -Path $src -Exclude $exclude | Where {$_.LastWriteTime -ge $(get-date).AddHours(-12)}  | Copy-Item -Destination $dest -recurse -Force
Copy-Item $outlook -Destination $dest -recurse -Force
Copy-Item $firefox -Destination $dest -recurse -Force
}
