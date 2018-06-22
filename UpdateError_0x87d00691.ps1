#script to rename a fine

function Update-Troubleshooter {

[cmdletbinding()]

param([parameter(Mandatory = $true,
                 valuefrompipeline=$true,
                 valuefrompipelinebypropertyname=$true,
                 helpmessage =" type computername")]
      
      [string[]]$computername
)


foreach ($machine in $computername) {
          
          Rename-item \\$machine\c$\Windows\System32\GroupPolicy\Machine\registry.pol \\$machine\c$\Windows\System32\GroupPolicy\Machine\registryold.pol

          net stop bits
          net stop wuauserv
          net stop appidsvc
          net stop cryptsvc

          Rename-Item \\$machine\c$\windows\SoftwareDistribution \\$machine\c$\windows\SoftwareDistribution.old

          net start bits
          net start wuauserv
          net start appidsvc
          net start cryptsvc


}


$renamed = Test-Path -Path \\$machine\c$\Windows\System32\GroupPolicy\Machine\registryold.pol

foreach ($machine in $computername) 

{ 

if($renamed -eq $true) { 

Restart-Service -Name CcmExec

}

else { Write-Verbose "file was not renamed on $machine"}

}

}