$Host.UI.RawUI.WindowTitle = 'ATtiny85 Blackjack'
[Console]::BackgroundColor = 'DarkBlue'
[Console]::ForegroundColor = 'White'
cls

Function Get-Card { return Get-Random -Min 1 -Max 12 }

Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "                ATtiny85 BLACKJACK v1.0                         " -ForegroundColor Yellow
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host ""

$pSum = 0; $dSum = 0
$pSum += Get-Card; $pSum += Get-Card
$dSum += Get-Card; $dSum += Get-Card

$playing = $true
while($playing) {
    Write-Host "Dealer showing: $dSum (Partial)" -ForegroundColor Gray
    Write-Host "Your total: $pSum" -ForegroundColor Green
    $action = Read-Host "Hit or Stand? (h/s)"
    
    if ($action -eq 'h') {
        $pSum += Get-Card
        if ($pSum -gt 21) {
            Write-Host "BUST! You hit $pSum." -ForegroundColor Red
            $playing = $false
        }
    } else {
        $playing = $false
    }
}

if ($pSum -le 21) {
    Write-Host "Dealer reveals: $dSum" -ForegroundColor Yellow
    while ($dSum -lt 17) {
        $card = Get-Card
        $dSum += $card
        Write-Host "Dealer hits and gets $card. Total: $dSum"
    }
    
    if ($dSum -gt 21 -or $pSum -gt $dSum) {
        Write-Host "YOU WIN!" -ForegroundColor Green
    } elseif ($dSum -eq $pSum) {
        Write-Host "PUSH (Tie)." -ForegroundColor Yellow
    } else {
        Write-Host "DEALER WINS!" -ForegroundColor Red
    }
}

Read-Host "Press Enter to exit"
