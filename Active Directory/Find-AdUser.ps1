function Find-ADUser {
        ${ADUserFirstName} = Read-Host -Prompt "Please provide the first name of the Active Directory user you are searching for"
        "`nYour results are being produced"
        Get-ADUser -Filter "givenname -like '$ADUserFirstName'" -Properties "Department","Description","telephoneNumber","OfficePhone"
# User has option to enter their own filter option with the associated info if they require more searching
        ${ADUserFirstNameRepeatSearch} = Read-Host -Prompt "Would you like to search another user first name?"

        while (($ADUserFirstNameRepeatSearch) -eq "yes" -or ($ADUserFirstNameRepeatSearch) -eq "y" ) {
            ${ADUserFirstNameNextSearch} = Read-Host -Prompt "Please provide the first name of the Active Directory user you are searching for"
            Get-ADUser -Filter "givenname -like '$ADUserFirstNameNextSearch'" -Properties "Department","Description","telephoneNumber","OfficePhone"; 
            ${ADUserFirstNameRepeatSearch} = Read-Host -Prompt "Would you like to search another user first name?";
            if (($ADUserFirstNameRepeatSearch) -eq "No" -or ($ADUserFirstNameRepeatSearch) -eq "n") {
                ${UserSearchFilterPrompt} = Read-Host -Prompt "`nIs there a different filter you would like to use?"
                if (($UserSearchFilterPrompt) -eq "yes" -or ($UserSearchFilterPrompt) -eq "y") {
                    ${ADUserFilter} = Read-Host -Prompt "`nPlease enter the name of the filter type you would like to use (E.g. surname, department, samaccountname)" 
                    ${ADUserFilterInfo} = Read-Host -Prompt "Type the information for your selected filter"
                    "`nYour results are being produced`n"
                    Get-ADUser -Filter {$ADUserFilter -like $ADUserFilterInfo} -Properties "Department","Description","telephoneNumber","OfficePhone"
                    "`nSearch complete."
                    } 
                    elseif (($UserSearchFilterPrompt) -eq "no" -or ($UserSearchFilterPrompt) -eq "n") {
                    Write-Host "`nSearch complete."
                    }
            }
             
        }
    }