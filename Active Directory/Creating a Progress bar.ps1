# Creates a useful progress bar for scripts

$outer=@(1..10)
$inner=@(1..100)

$counter=1
foreach($x in $outer){
    Write-Progress -Id 1 -Activity "Progress" -Status "$(($counter/$outer.Count)*100)% Complete" -PercentComplete $(($counter/$outer.Count)*100)
    $counter++
    Start-Sleep -Milliseconds 100
}