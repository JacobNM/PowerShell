
$ADUserFirstNameQuery = Read-Host -Prompt "Please provide the first name of the Active Directory user you are searching for"
    "Your results are being produced"

$ADUserFirstNameList = @();

$ProgCounter=0
foreach ($User in $ADUserFirstNameQuery){
    $ADUserFirstNameList += Get-ADUser -Filter "givenname -like '$ADUserFirstNameQuery'" -Properties "Description"
    start-sleep -Milliseconds 300
    Get-ADUser -Filter "givenname -like '$ADUserFirstNameQuery'" -Properties "Description"
    Write-Progress -Activity "Searching..." -Status "$(($ProgCounter/$ADUserFirstNameList.count)* 100)% Complete" 
    $ProgCounter ++

}
"Search complete"