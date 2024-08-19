#Check for Windows updates
Get-Date | Write-output
Function CheckFeatureUpdates(){
    If(-not(Get-InstalledModule PSWindowsUpdate -ErrorAction silentlycontinue)){
    Install-packageprovider -name nuget -minimumversion 2.8.5.201 -force | Out-Null
    Install-Module PsWindowsUpdate -Confirm:$False -Force | write-host "Installing Update Module to "$env:COMPUTERNAME" "
    }
    #Get All Results
    $Results = Get-Windowsupdate -NotCategory Driver
    #Create Keywords for Update Search
    $update = @{Update1 = "*Feature*" ; Update2 = "*Update for Windows 10*"}
     
    foreach ($key in $update.values){
        $results | foreach-object {
            if ($_.title -like $key){
                $_
            }
        }
    }
}

#Check for Updates then Install Feature Update if present or Regular Update
$Updates = CheckFeatureUpdates
if($Updates){
    if($Updates | where title -like *"Feature update"*)
        {
        $KBs = $Updates | where title -like *"Feature update"* | select KB
        Install-WindowsUpdate -KBArticleID $KBs -AcceptAll -ForceDownload -ForceInstall -IgnoreReboot 
        }
    Else{
        $KBs = $Updates | where title -like *"Update for Windows 10"* | select KB
        Install-WindowsUpdate -KBArticleID $KBs -AcceptAll -ForceDownload -ForceInstall -IgnoreReboot 
        }
}

Else {Write-Host "Desired Updates are not Available"}