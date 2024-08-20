#Get Users in Local Admin Group
$members = net localgroup administrators
$membercleanup = $members[6..($members.Length-3)] | Sort-Object 
# Create Array of Admins
$Admins = @{}
#For Each loop through Local Admin Group flagging  undesired accounts to true.
foreach ($Administrator in $MemberCleanup){

    IF ($administrator -eq 'StandardJoe'){
        $value = $false
        Write-host 'Remote support account detected'
    }
    Elseif ($administrator -eq 'Contoso\Domain Admins'){
        $value = $false
        write-host 'Domain Admin Account Detected'
    }
    Elseif ($administrator -eq 'Administrator'){
        $value = $false
        write-host 'Administrator Account Detected'
    }
    else{
        $value = $true
    }
    $Admins.add( $Administrator, $value )
}

write-host ""
#Loop through ARray and remove flagged accounts
function DecisionTree(){
    $admins.GetEnumerator() | ForEach-Object {
        if ( $_.value -eq $True){ 
            Write-Host $_.key "Will be deleted"
            #net localgroup administrators $($item.key) /delete 
        }
        else{
            Write-Host $_.Key "Will not be deleted"
        }
    }
}

 DecisionTree
 