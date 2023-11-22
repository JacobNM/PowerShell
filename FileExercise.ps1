$FirstName = Read-Host "Enter your first name"
$LastName = Read-Host "Enter your last name"

$Today = get-date -Format "dd-MM-yyyy HH-mm"

Set-Content -Value "First Name: $FirstName`nLast Name: $LastName`nDate: $Today" -Path "C:\ScriptChallenge\$Today-$FirstName-$LastName.txt"