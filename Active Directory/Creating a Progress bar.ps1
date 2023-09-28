# Creates a useful progress bar for scripts

$outer=@(1..10)
$inner=@(1..100)

$counter=1
foreach($x in $outer){
    $innercounter=1
    foreach($y in $inner){
        Write-Progress -Id 2 -Activity "Inner Loop" -Status "$(($innercounter/$inner.Count)*100)% Complete" -PercentComplete $(($innercounter/$inner.Count)*100)
    $innercounter++
    Start-Sleep -Milliseconds 100
    }
    Write-Progress -Id 1 -Activity "Outer Loop" -Status "$(($counter/$outer.Count)*100)% Complete" -PercentComplete $(($counter/$outer.Count)*100)
    $counter++
    Start-Sleep -Milliseconds 100
}