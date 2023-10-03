# Script is designed to create a new Active Directory (AD) user, including common attribute fields found in AD

"`nWelcome to the Active Directory - New User setup"
"`nThis script is designed to present you with the most common attribute fields entered for new hires.`n
If no information is necessary for an attribute field, type 'N/A' to proceed to the next field.`n
Please enter the necessary information for the following fields:`n"

# User fills out Active directory attribute fields at each prompt
$NewUserFirstName = Read-Host -Prompt "First Name"
$NewUserLastName = Read-Host -Prompt "Last Name"
$NewUserFullName = Read-Host -Prompt "Full Name (E.g. John Doe)"
$NewUserDisplayName = Read-Host -Prompt "Display Name"
$NewUserEmployeeID = Read-Host -Prompt "Employee ID"
$NewUserTitle = Read-Host -Prompt "Title"
$NewUserDepartment = Read-Host -Prompt "Department"
$NewUserDescription = Read-Host -Prompt "Description"
$NewUserTelephone = Read-Host -Prompt "Office Number"
$NewUserEmail = Read-Host -Prompt "Email Address"
$NewUserSamAccountName = Read-Host -Prompt "Sam Account Name (E.g. jdoe)"
$NewUserPrincipalName = Read-Host -Prompt "User Principal Name (E.g. jdoe@headwatershealth.ca)"
$NewUserOffice = Read-Host -Prompt "Office"

# Account is created; user is notified at start and end of process
"`nYour information is being entered for the new hire"

# Creates a new user based off of information entered in variables above ^
New-ADUser -GivenName "$NewUserFirstName" -Surname "$NewUserLastName" -DisplayName "$NewUserDisplayName" -Name "$NewUserFullName" `
        -Title "$NewUserTitle" -Description "$NewUserDescription" -OfficePhone "$NewUserTelephone" `
        -EmailAddress "$NewUserEmail" -Department "$NewUserDepartment" -EmployeeID "$NewUserEmployeeID" `
        -Office "$NewUserOffice" -SamAccountName "$NewUserSamAccountName" -UserPrincipalName "$NewUserPrincipalName"

"`nNew employee account created. Check active directory to ensure the information entered is correct`n"