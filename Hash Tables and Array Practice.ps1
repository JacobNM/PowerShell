# Creating some examples of arrays for practice purposes

$Numbers = (1..10)

$Letters = ("a","b","c","d","e","f","g","h","i","j")

$NumbersAndLetters = $Numbers + $Letters
$NumbersAndLetters

# Creating some examples of hashtables for practice purposes

$Dogs = New-Object -TypeName psobject -Property @{"Dog Names"= "Boomer","Clifford","Fido"
                                                    "Colour" = "Brown","Red","White"
                                                 } | Format-List 
$Dogs

#Good example of implementing a hash table
function Get-FolderStats ([string]$path){
   $files = Get-ChildItem $path -Recurse | Where-Object {!$_.PSIsContainer}
   $TotalFiles = $files | Measure-Object -Property Length -Sum
   $FileStats = "" | Select-Object path,count,
                                @{Name = "Size (GB)"; Expression = {[math]::Round($TotalFiles.sum/1gb,2)}}
                             #Hash table example ^
       $FileStats.path = $path
       $FileStats.count = $TotalFiles.Count
       return $FileStats
}
Get-FolderStats "C:\Users\jmartin\Downloads"