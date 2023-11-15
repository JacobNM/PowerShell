# Parameters

Param([string]$source = "", [string] $destination = "")

# Functions

#Function used to find specified folders - and create them - if they do not exist.
function Search-Folder ([string]$path, [switch]$create) {
    $FolderExists = Test-Path $path
    
    if(!$FolderExists -and $create){
        #creates the directory if it does not exist
        write-host "`nFolder does not exist ($ExtDestinationDir). Creating now.`n"
        mkdir $path | Out-Null
        $FolderExists = Test-Path $path
    }
    return $FolderExists
}

#Function provides brief stats on specified folder - Folder path name;including extension, number of files in folder, and size (GB) - of folder
function Get-FolderStats ([string]$path){
    $files = Get-ChildItem $path -Recurse | Where-Object {!$_.PSIsContainer}
    $TotalFiles = $files | Measure-Object -Property Length -Sum
    $FileStats = "" | Select-Object path,count,
                            @{Name = "Size (GB)"; Expression = {[math]::Round($TotalFiles.sum/1gb,2)}}
        $FileStats.path = $path
        $FileStats.count = $TotalFiles.Count
        return $FileStats
}

# Main processing

# Tests for existence of the source folder with search-folder function.
$SourceExists = Search-Folder $source
if (!$SourceExists){
    Write-Host "The source directory does not exist. Script cannot continue."
    Exit
}

# Tests for the existence of the destination folder using the search-folder function
# If the folder is not found, it can be created with the -create parameter attached to the search-folder function
$DestinationExists = Search-Folder $destination -create
if (!$DestinationExists){
    Write-Host "the destination folder does not exist. Creating folder."
    exit
}

# Copy files to their appropriate destination
$files = Get-ChildItem $source -Recurse | Where-Object {!$_.PSIsContainer}

foreach ($file in $files){
    $Extension = $file.Extension.replace(".","")
    $ExtDestinationDir = "$destination\$extension"
    $ExtDestinationDir
    $ExtDestinationDirExists = Search-Folder $ExtDestinationDir -create
    if (!$ExtDestinationDirExists){
        Write-Host "The destination directory ($extdestinationdir) can't be created. Exiting script."
        exit
    }
    
    # Copy files
    Copy-Item $file.FullName $ExtDestinationDir
}
# Notifies user of successful file copy and provides brief info on the transfer.
"`nFiles copied successfully."
"`n"; Get-FolderStats $destination; "`n"