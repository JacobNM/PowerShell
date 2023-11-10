function Find-ADUser {
    ${ADUserFirstName} = Read-Host -Prompt "Please provide the first name of the Active Directory user you are searching for"
    "`nYour results are being produced"
    Get-ADUser -Filter {givenname -eq $ADUserFirstName} -Properties "Department","Description","telephoneNumber","OfficePhone" | 
    Select-Object department,Description,distinguishedname,enabled,objectclass,OfficePhone,telephoneNumber,samaccountname,UserPrincipalName,
        @{Name="First Name";Expression = {$_.givenname}},
        @{Name = "Last Name"; Expression = {$_.surname}} | 
    Format-List "First Name","Last Name",Description,Department,OfficePhone,telephoneNumber,samaccountname,UserPrincipalName,distinguishedname,objectclass,enabled
    
    # User has option to enter another first name if they require more searching
    ${ADUserFirstNameRepeatSearch} = Read-Host -Prompt "Would you like to search another user first name?"
    
    #User will have the opportunity to continue searching by first name so long as they continue to answer "yes" when prompted
    while (($ADUserFirstNameRepeatSearch) -eq "yes" -or ($ADUserFirstNameRepeatSearch) -eq "y" ) {
        ${ADUserFirstNameNextSearch} = Read-Host -Prompt "Please provide the first name of the Active Directory user you are searching for"
        Get-ADUser -Filter {givenname -eq $ADUserFirstNameNextSearch} -Properties "Department","Description","telephoneNumber","OfficePhone" |
        Select-Object department,Description,distinguishedname,enabled,objectclass,OfficePhone,telephoneNumber,samaccountname,UserPrincipalName,
            @{Name="First Name";Expression = {$_.givenname}},
            @{Name = "Last Name"; Expression = {$_.surname}} | 
        Format-List "First Name","Last Name",Description,department,OfficePhone,telephoneNumber,samaccountname,UserPrincipalName,distinguishedname,objectclass,enabled
        ${ADUserFirstNameRepeatSearch} = Read-Host -Prompt "Would you like to search another user first name?";
    }
        
    # Provides opportunity to search AD using a different property as the filter
    if (($ADUserFirstNameRepeatSearch) -eq "No" -or ($ADUserFirstNameRepeatSearch) -eq "n") {
        ${UserSearchFilterPrompt} = Read-Host -Prompt "`nIs there a different filter you would like to use?"
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
        ${UserSearchFilterPrompt} = Read-Host -Prompt "Would you like to search another filter type?"
        }

    if (($UserSearchFilterPrompt) -eq "no" -or ($UserSearchFilterPrompt) -eq "n") {
        Write-Host "`nSearch complete."
        }
                
   }