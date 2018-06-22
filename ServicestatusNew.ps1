$servers = get-content "C:\ServiceStateAfterPatching\emsservers.txt"

foreach ($server in $servers) {

Enter-PSSession -ComputerName $server

$smsagentstatus = (Get-Service ccmexec).Status
$SMS_EXECUTIVE = (Get-Service SMS_EXECUTIVE).Status
$SMS_COMP_MGR = (Get-Service SMS_SITE_COMPONENT_MANAGER).Status
$SMS_SQL = (Get-Service "SQL Server (CONFIGMGRSEC)").Status
$SQLBrowser = (Get-Service SQLBrowser).Status
$WDSServer = (Get-Service "Windows Deployment Services Server" ).Status
$WsusService = (Get-Service WsusService ).Status
$IISADMIN = (Get-Service IISADMIN ).Status

if(($smsagentstatus).status -eq "running") {

Write-Verbose "CcmExec is running" -Verbose

Else { (Get-Service CcmExec).Start()

}

}

if(($SMS_EXECUTIVE).status -eq "running") {

Write-Verbose "SMS_EXE is running" -Verbose

Else { (Get-Service SMS_EXECUTIVE).Start()

}

}

if(($SMS_COMP_MGR).status -eq "running") {

Write-Verbose "SMS_SITE_COMPONENT_MANAGER is running" -Verbose

Else { (Get-Service SMS_SITE_COMPONENT_MANAGER).Start()

}

}

if(($SMS_SQL).status -eq "running") {

Write-Verbose "MSSQL$CONFIGMGRSEC is running" -Verbose

Else { (Get-Service "SQL Server (CONFIGMGRSEC)").Start()

}

}

if(($SQLBrowser).status -eq "running") {

Write-Verbose "SQLBrowser is running" -Verbose

Else { (Get-Service SQLBrowser).Start()

}

}

if(($WDSServer).status -eq "running") {

Write-Verbose "WDSServer is running" -Verbose

Else { (Get-Service "Windows Deployment Services Server").Start()

}

}

if(($WsusService).status -eq "running") {

Write-Verbose "WsusService is running" -Verbose

Else { (Get-Service WsusService).Start()

}

}

if(($IISADMIN).status -eq "running") {

Write-Verbose "IISADMIN is running" -Verbose

Else { (Get-Service IISADMIN).Start()

}

}

}