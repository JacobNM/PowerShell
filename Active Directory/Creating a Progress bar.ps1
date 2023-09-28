# Creates a useful progress bar for scripts

$outer=@(1..10)
$inner=@(1..100)

$counter=1
foreach($x in $outer){
    Write-Progress -Id 1 -Activity "Loop" -Status "$(($counter/$outer.Count)*100)% Complete" -PercentComplete
    $counter++
    Start-Sleep -Milliseconds 100
}