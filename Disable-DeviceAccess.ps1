#Remove Password Login from Device
New-ItemProperty -path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60B78E88-EAD8-445C-9CFD-0B87F74EA6CD}'-name 'Disabled' -value '1' -PropertyType 'DWord' -Force
#Clear TPM of Windows Hello Credentials
Clear-TPM
#Force Bitlocker Recovery 
manage-bde -forcerecovery C:
manage-bde -protectors -enable C:
#Restart
shutdown -f -r -t 0