#Create Directory
If (Test-Path -Path "C:\Windows\Secure"){
    While(Get-ChildItem C:\windows\secure\ | Where-Object Name -like *"azcopy_windows_amd64"*){
    $foldername = "C:\Windows\Secure\" + (Get-ChildItem C:\windows\secure\ | Where-Object Name -like *"azcopy_windows_amd64"*).Name
    Remove-Item $filename -Recurse
    }   
}
Else{
New-Item -Type Directory -Path "C:\Windows\Secure" | Out-Null
}

#download Azcopy and unzip
Invoke-WebRequest -uri "https://aka.ms/downloadazcopy-v10-windows" -OutFile "C:\Windows\Secure\azcopy.zip"
Expand-Archive C:\Windows\Secure\azcopy.zip C:\Windows\Secure\ -force
$foldername = "C:\Windows\Secure\" + (Get-ChildItem C:\windows\secure\ | Where-Object Name -like *"azcopy_windows_amd64"*).Name
Set-Location $foldername
 


#stage upload directory path
$name = hostname
$date = get-date -Format yyyyMMdd
$dir = "C:\windows\Secure\$($name)-$($date)"
mkdir $dir -Force

#copy desired contents to path
cp "<File Path>" $dir -Recurse -Force

#upload to Azure Blob
.\azcopy.exe copy $dir "<Blob Storage Path>" --recurse
