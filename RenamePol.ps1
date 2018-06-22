$wuahandler = get-content c:\Windows\CCM\Logs\WUAHandler.log -tail 3

if($wuahandler -match "0x80004005") {

Rename-Item c:\Windows\System32\GroupPolicy\Machine\Registry.pol -NewName c:\Windows\System32\GroupPolicy\Machine\registryold1.pol -Force

}

else {

break

}

$regpol = test-path "c:\Windows\System32\GroupPolicy\Machine\registryold1.pol"


do{Start-Sleep -Seconds 2 } 


until(

$regpol -eq $true

)

$trigger = "{00000000-0000-0000-0000-000000000113}"

Invoke-WmiMethod -Namespace root\ccm -Class sms_client -Name TriggerSchedule $trigger -ErrorAction SilentlyContinue