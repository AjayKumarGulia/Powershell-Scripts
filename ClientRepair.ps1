
#Define Variables

$case = Read-Host " To uninstall and re-install, type < R >, To troubleshoot fatal error- 1603, while installing client, type < T >, For fresh install, copy ccmsetup.exe in c:\windows folder and re-run this script and type < I >"

#case 1, when user is unintsalling and re-installing the sccm client to repair it

if ($case -eq "R") {

#define Variables

$filesexist1 = Test-Path "C:\Windows\ccmsetup\vc50727_x64.exe"

$filesexist2 = Test-Path "C:\Windows\ccmsetup\vcredist_x64.exe"

$filesexist3 = Test-Path "C:\Windows\ccmsetup\SCEPInstall.exe"

cd "C:\windows\ccmsetup"

.\ccmsetup.exe /uninstall

if ($filesexist1, $filesexist2, $filesexist3 -eq $true){

do { Start-Sleep -s 60 }

until ($filesexist1, $filesexist2, $filesexist3 -eq $false)}

$mp = Read-Host "type local secondary site mp with FQDN"

$SMSMP = Read-Host "type primary site with FQDN"

if($filesexist1, $filesexist2, $filesexist3 -eq $false)

  {.\ccmsetup.exe /mp:$mp smsmp=$SMSMP /install}

}

#case 2, when user gets fatal error 1603, while installing sccm client.

if ( $case -eq "T" ) {

copy C:\Windows\ccmsetup\ccmsetup.exe C:\Windows

Try { Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force -ErrorAction Stop } Catch {}

# Stop Services
Stop-Service -Name ccmsetup -Force -ErrorAction SilentlyContinue
Stop-Service -Name CcmExec -Force -ErrorAction SilentlyContinue
Stop-Service -Name smstsmgr -Force -ErrorAction SilentlyContinue
Stop-Service -Name CmRcService -Force -ErrorAction SilentlyContinue

# Remove WMI Namespaces
Get-WmiObject -Query "SELECT * FROM __Namespace WHERE Name='ccm'" -Namespace root | Remove-WmiObject
Get-WmiObject -Query "SELECT * FROM __Namespace WHERE Name='sms'" -Namespace root\cimv2 | Remove-WmiObject

# Remove Services from Registry
$MyPath = “HKLM:\SYSTEM\CurrentControlSet\Services”
Remove-Item -Path $MyPath\CCMSetup -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $MyPath\CcmExec -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $MyPath\smstsmgr -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $MyPath\CmRcService -Force -Recurse -ErrorAction SilentlyContinue

# Remove SCCM Client from Registry
$MyPath = “HKLM:\SOFTWARE\Microsoft”
Remove-Item -Path $MyPath\CCM -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $MyPath\CCMSetup -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $MyPath\SMS -Force -Recurse -ErrorAction SilentlyContinue

# Remove Folders and Files
$MyPath = $env:WinDir
Remove-Item -Path $MyPath\CCM -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $MyPath\ccmsetup -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $MyPath\ccmcache -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $MyPath\SMSCFG.ini -Force -ErrorAction SilentlyContinue
Remove-Item -Path $MyPath\SMS*.mif -Force -ErrorAction SilentlyContinue

#Variables

$mp = Read-Host "type local secondary site mp with FQDN"

$SMSMP = Read-Host "type primary site with FQDN" 

cd "C:\windows"

.\ccmsetup.exe /mp:$mp smsmp=$SMSMP /install}

#case 3 - When user is installing client for the first time on a machine.

if ( $case -eq "I") {

$mp = Read-Host "type local secondary site mp with FQDN"

$SMSMP = Read-Host "type primary site with FQDN" 

cd "C:\windows"

.\ccmsetup.exe /mp:$mp smsmp=$SMSMP /install }

else { Write-Host " Please input a valid response " } 
