$Host.UI.RawUI.WindowTitle = 'ATtiny85 Terminal Arcade'
[Console]::BackgroundColor = 'DarkBlue'
[Console]::ForegroundColor = 'White'
cls

Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "                ATtiny85 TERMINAL ARCADE v2.0                   " -ForegroundColor Yellow
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host " Welcome, player! Beat the digital slot machine." -ForegroundColor Green
Write-Host ""

$credits = 100
while ($credits -gt 0) {
    Write-Host "----------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host " Current Credits: $credits" -ForegroundColor Yellow
    $choice = Read-Host " Press [Enter] to Spin (Cost: 10) or type 'q' to quit"
    if ($choice -eq 'q') { break }
    
    $credits -= 10
    $s1 = Get-Random -Min 1 -Max 4
    $s2 = Get-Random -Min 1 -Max 4
    $s3 = Get-Random -Min 1 -Max 4

    Write-Host ""
    Write-Host "          [ $s1 ]   [ $s2 ]   [ $s3 ]          " -ForegroundColor Cyan
    Write-Host ""

    if ($s1 -eq $s2 -and $s2 -eq $s3) {
        Write-Host " >>> JACKPOT! You won 50 credits! <<<" -ForegroundColor Magenta
        $credits += 60
    } elseif ($s1 -eq $s2 -or $s2 -eq $s3 -or $s1 -eq $s3) {
        Write-Host " -> Small Match! You won 15 credits." -ForegroundColor Green
        $credits += 25
    } else {
        Write-Host " X No match. Better luck next time." -ForegroundColor Red
    }
    Write-Host ""
}

Write-Host "================================================================" -ForegroundColor Cyan
Write-Host " Game Over! Thanks for playing." -ForegroundColor Yellow
Write-Host "================================================================" -ForegroundColor Cyan
Read-Host "Press Enter to close window"
