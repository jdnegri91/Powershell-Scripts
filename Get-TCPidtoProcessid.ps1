#Get Running Processes
$Processes = Get-Process | Select-Object ProcessName,ID
#Get Listening Ports
$TCP = Get-NetTCPConnection -State Listen -Verbose
#Capture Processes Ids
$TCPID = $TCP.OwningProcess
#Loop through Processes IDS for matching running process
For ($i=0; $i -le $tcp.Length; $i++){

    $Processes | ForEach-Object { 

    
    if($_.Id -eq $tcpid[$i]) 
    
    {Write-Host $_.processname "Has Port" $TCP.localport[$i] "open" }  

}
}
 