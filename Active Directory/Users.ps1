#Create a new AD user
New-ADUser -Name "test" -GivenName "test" -Surname "test" -UserPrincipalName "test@domain.com" -SamAccountName "test" -Office "test" -EmployeeID "00000000"

# Used to find an AD user based on their identity and provide all available properties for the user
Get-ADUser -identity "test" -Server "hhcc.on.ca" -properties *

# Used to find all users on a particular AD server
Get-ADUser -Filter {EmployeeID -like "*"} -Server "hhcc.on.ca" -Properties "Employeeid"

# Used to remove AD users by their name (First and last)
Remove-ADUser "Jacob Test"

# Can be used to locate particular AD groups by their name & list available properties for the specified group
Get-ADGroup "domain users" -Properties *

# Can be used to locate & list users in areas of AD using the searchbase parameter
Get-ADUser -filter * -SearchBase "CN=Users,DC=hhcc,DC=on,DC=ca"

# Can be used to find & list groups in AD using the searchbase parameter
Get-ADGroup -filter * -SearchBase "CN=Users,DC=hhcc,DC=on,DC=ca"

# Can be used to find a AD member using their last name as the filter
    # Remove the properties argument for a simplified result
get-aduser -filter 'surname -like "costanza"' -Properties *

# Can be used to find an AD member using their first name as the filter
    # Remove the properties argument for a simplified result
get-aduser -filter 'givenname -like "George"' -Properties *

# Used to import employee info from a CSV file and verify accuracy of CSV with a grid-view window
Import-Csv -Path "C:\Users\jmartin\users.csv" | Out-GridView

# Used to import employee info from a CSV file and add users to Active Direcotory
Import-Csv "C:\Users\jmartin\users.csv" | New-ADUser -AccountPassword $(ConvertTo-SecureString "Password1!" -AsPlainText -force) -ChangePasswordAtLogon $true -Enabled $true

# Used to observe action of command to determine if it achieves the desired effect; will not actually perform action
# Will remove users from CSV file based on SAMaccountName
Import-Csv "C:\Users\jmartin\users.csv" | ForEach-Object {Remove-ADUser -Identity $_.SamAccountName -WhatIf}

# Used to remove multiple users from active directory using a CSV file; will not ask for confirmation to save time
Import-Csv "C:\users\jmartin\users.csv" | ForEach-Object {Remove-ADUser -Identity $_.SamAccountName -Confirm:$false}