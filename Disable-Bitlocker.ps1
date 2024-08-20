#Disable Bitlocker
Manage-bde -off C:


#Check Status until finished decrypting
$Status = $false
While($Status -eq $false){
    $bitlocker = Manage-bde -status
    $bitlockerstatus = $bitlocker| Where-Object {$_ -match 'Conversion Status'}
    If($bitlockerstatus -like "*Decryption in Progress*"){
        Write-output "Disk is Decrypting"
        sleep 10
        }
    else{
        Write-output "Disk Decrypted"
        $Status = $True
    }

}
