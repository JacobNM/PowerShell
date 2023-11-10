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

