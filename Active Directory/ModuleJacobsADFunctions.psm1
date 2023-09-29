# Can be used to find an AD member using their first name as the filter
function Find-ADUser {
    $ADUserFirstName = Read-Host -Prompt "Please provide the first name of the Active Directory user you are searching for"
    "`nYour results are being produced"
    Get-ADUser -Filter "givenname -like '$ADUserFirstName'" -Properties "Description"  

# User has option to enter their own filter option with the associated info if they require more searching
        $UserSearchFilterPrompt = Read-Host -Prompt "`nIs there a different filter you would like to use?"

        if ($UserSearchFilterPrompt -eq "yes" -or "y") {
            $ADUserFilter = Read-Host -Prompt "`nPlease enter the name of the filter type you would like to use" ; 
            $ADUserFilterInfo = Read-Host -Prompt "Type the information for your selected filter" ; "`n"
            Get-ADUser -Filter {$ADUserFilter -like $ADUserFilterInfo} -Properties "Description"
            "`nSearch complete! Hope this was helpful."
        }

        else {Write-Host "`nSearch complete! Hope this was helpful."}
    }