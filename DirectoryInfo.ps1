# Creates a function to determine how much space is being used in specified folders/areas of computer

function get-dirinfo($dir)
{
    $results = Get-ChildItem $dir -Recurse | Measure-Object -Property Length -Sum
    return [math]::Round(($results).sum/1gb,5)
}
get-dirinfo C:\Users