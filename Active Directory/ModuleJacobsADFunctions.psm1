# Creates a useful progress bar for scripts
function ProgressBar { 
    
$outer=@(1..10)
$inner=@(1..100)

$counter=1
foreach($x in $outer){
    $innercounter=1
    foreach($y in $inner){
        Write-Progress -Id 2 -Activity "Inner Loop" -Status "$(($innercounter/$inner.Count)*100)% Complete" -PercentComplete $(($innercounter/$inner.Count)*100)
    $innercounter++
    Start-Sleep -Milliseconds 100
    }
    Write-Progress -Id 1 -Activity "Outer Loop" -Status "$(($counter/$outer.Count)*100)% Complete" -PercentComplete $(($counter/$outer.Count)*100)
    $counter++
    Start-Sleep -Milliseconds 100
                    }
    }
    function Find-ADUser {
        ${ADUserFirstName} = Read-Host -Prompt "`nPlease provide the first name of the Active Directory user you are searching for"
        "`nYour results are being produced"
        Get-ADUser -Filter {givenname -eq $ADUserFirstName} -Properties "Department","Description","telephoneNumber","OfficePhone" | 
        Select-Object department,Description,distinguishedname,enabled,objectclass,OfficePhone,telephoneNumber,samaccountname,UserPrincipalName,
            @{Name="First Name";Expression = {$_.givenname}},
            @{Name = "Last Name"; Expression = {$_.surname}} | 
        Format-List "First Name","Last Name",Description,Department,OfficePhone,telephoneNumber,samaccountname,UserPrincipalName,distinguishedname,objectclass,enabled
        
        "`nSearch complete."

        # User has option to enter another first name if they require more searching
        ${ADUserFirstNameRepeatSearch} = Read-Host -Prompt "Would you like to search another user first name?`n[Y] Yes [N] No"
        
        #User will have the opportunity to continue searching by first name so long as they continue to answer "yes" when prompted
        while (($ADUserFirstNameRepeatSearch) -eq "yes" -or ($ADUserFirstNameRepeatSearch) -eq "y" ) {
            ${ADUserFirstNameNextSearch} = Read-Host -Prompt "`nPlease provide the first name of the Active Directory user you are searching for"
            Get-ADUser -Filter {givenname -eq $ADUserFirstNameNextSearch} -Properties "Department","Description","telephoneNumber","OfficePhone" |
            Select-Object department,Description,distinguishedname,enabled,objectclass,OfficePhone,telephoneNumber,samaccountname,UserPrincipalName,
                @{Name="First Name";Expression = {$_.givenname}},
                @{Name = "Last Name"; Expression = {$_.surname}} | 
            Format-List "First Name","Last Name",Description,department,OfficePhone,telephoneNumber,samaccountname,UserPrincipalName,distinguishedname,objectclass,enabled
            
            "`nSearch complete."

            ${ADUserFirstNameRepeatSearch} = Read-Host -Prompt "Would you like to search another user first name?`n[Y] Yes [N] No";
        }
            
        # Provides opportunity to search AD using a different property as the filter
        if (($ADUserFirstNameRepeatSearch) -eq "No" -or ($ADUserFirstNameRepeatSearch) -eq "n") {
            ${UserSearchFilterPrompt} = Read-Host -Prompt "`nIs there a different filter you would like to use?`n[Y] Yes [N] No"
            }    
        #User will have the opportunity to continue searching by first name so long as they continue to answer "yes" when prompted   
        while (($UserSearchFilterPrompt) -eq "yes" -or ($UserSearchFilterPrompt) -eq "y") {
            ${ADUserFilter} = Read-Host -Prompt "`nPlease enter the name of the filter type you would like to use (E.g. surname, department, samaccountname)" 
            ${ADUserFilterInfo} = Read-Host -Prompt "Type the information for your selected filter"
            "`nYour results are being produced`n"     
            Get-ADUser -Filter {$ADUserFilter -eq $ADUserFilterInfo} -Properties "Department","Description","telephoneNumber","OfficePhone" |
            Select-Object department,Description,distinguishedname,enabled,objectclass,OfficePhone,telephoneNumber,samaccountname,UserPrincipalName,
                @{Name="First Name";Expression = {$_.givenname}},
                @{Name = "Last Name"; Expression = {$_.surname}}| 
            Format-List "First Name","Last Name",Description,Department,OfficePhone,telephoneNumber,samaccountname,UserPrincipalName,distinguishedname,objectclass,enabled
            "Search complete.`n"
            #Gives user the opportunity to continue searching using a custom filter
            ${UserSearchFilterPrompt} = Read-Host -Prompt "Would you like to search another filter type?`n[Y] Yes [N] No"
            }
    
        if (($UserSearchFilterPrompt) -eq "no" -or ($UserSearchFilterPrompt) -eq "n") {
            Write-Host "`nSearch complete."
            }
                    
       }

# Script is designed to create a new Active Directory (AD) user, including common attribute fields found in AD
    function Add-NewADUser {

"`nWelcome to the Active Directory - New User setup"
"`nThis script is designed to present you with the most common attribute fields entered for new hires.`n
If no information is necessary for an attribute field, press enter to proceed to the next field.`n
Please enter the necessary information for the following fields:`n"

# User fills out Active directory attribute fields at each prompt
$NewUserFirstName = Read-Host -Prompt "First Name"
$NewUserLastName = Read-Host -Prompt "Last Name"
$NewUserFullName = Read-Host -Prompt "Full Name (E.g. John Doe)"
$NewUserDisplayName = Read-Host -Prompt "Display Name (E.g. John Doe)"
$NewUserEmployeeID = Read-Host -Prompt "Employee ID"
$NewUserTitle = Read-Host -Prompt "Title (E.g. Doctor)"
$NewUserDepartment = Read-Host -Prompt "Department (E.g. IT)"
$NewUserDescription = Read-Host -Prompt "Description"
$NewUserTelephone = Read-Host -Prompt "Office Telephone Number"
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
    }