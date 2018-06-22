
Restart-Service -Name CcmExec

$servicestate = (Get-Service -Name CcmExec).Status

If($servicestate -eq "running"){

$sms = new-object –comobject “Microsoft.SMS.Client”

if ($sms.GetAssignedSite() –ne $sms.AutoDiscoverSite() ) { $sms.SetAssignedSite($sms.AutoDiscoverSite()) }

Start-Sleep -Seconds 10

if( $sms.GetAssignedSite() –eq $sms.AutoDiscoverSite()

){

$trigger = "{00000000-0000-0000-0000-000000000113}"

Invoke-WmiMethod -Namespace root\ccm -Class sms_client -Name TriggerSchedule $trigger -ErrorAction SilentlyContinue

#WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000113}" /NOINTERACTIVE 

}

else {

Start-Sleep -Seconds 5

}

} 

else{

Start-Sleep -Seconds 4

}

