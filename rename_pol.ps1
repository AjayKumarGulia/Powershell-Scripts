
$a = Get-Content -Path C:\Users\ajay.kumar\Desktop\WUAHandler.log -Tail 1

if($a  -match 'Error = 0x80004005' -eq $true) {

Rename-item C:\windows\System32\GroupPolicy\Machine\Registry.pol -NewName C:\windows\System32\GroupPolicy\Machine\Registryold2.old

}

else{ 

Write-Verbose "error not found"

}

Invoke-WmiMethod -Namespace root\ccm -Class sms_client -Name TriggerSchedule {00000000-0000-0000-0000-000000000113} -ErrorAction SilentlyContinue

