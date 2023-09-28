# In order to gain access to custom modules/functions/Scripts you create, environment must be configured in PowerShell
# Examples below:
    # $env:path += ";C:\Users\jmartin\Documents\WindowsPowerShell\Modules"
    # $env:path += ";C:\Users\jmartin\Documents\WindowsPowerShell\Powershell"

# Creates a useful alias for notepad for quicker access to application
    # new-item -path alias:np -value notepad | Out-Null

# Example of Yubikey (Application) Setup
    # Set-Alias ykman "C:\Program Files\Yubico\YubiKey Manager\ykman.exe“