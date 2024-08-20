#Check for Directory and Create if not present

If (Test-Path -Path "C:\Windows\Secure"){
    Remove-Item -path "C:\Windows\Secure" -Recurse -Force
    New-Item -Type Directory -Path "C:\Windows\Secure" | Out-Null
    Set-Location "C:\Windows\Secure" 
    }
Else{
    New-Item -Type Directory -Path "C:\Windows\Secure" | Out-Null
    Set-Location "C:\Windows\Secure"
    }
#Download Windows Defender for Endpoint GPO onboarind script
Invoke-WebRequest -Uri "" -OutFile "C:\Windows\secure\WindowsDefenderATPOnboardingScript.cmd"

#Create Scheduled Task
$action = New-ScheduledTaskAction -Execute "C:\Windows\secure\WindowsDefenderATPOnboardingScript.cmd"
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(5)
$principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -MultipleInstances Parallel
$task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings
Register-ScheduledTask -TaskName "Windows Defender for Endpoint Enrollment" -InputObject $task

