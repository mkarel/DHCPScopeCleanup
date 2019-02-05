$ScopeID = "10.136.24.0"
$DHCPServer = ""
$IPS = Get-DhcpServerv4Lease -ScopeId $ScopeID -ComputerName $DHCPServer |where-object {$_.Hostname -notlike "BAD_ADDRESS"}
foreach ($IP in $ips){
    $IPAddress = $IP.IPAddress
    $HostName =  $IP.hostname 
    
      If(Test-Connection $IPAddress -Count 2 -Quiet){
          write-host "Succesful ping $HostName ($IPAddress)"
        }else{
            write-host "Removing $HostName ($IPAddress) from DHCP Lease table"
           Remove-DhcpServerv4Lease -IPAddress $IPAddress -ComputerName $DHCPServer
      }

}
