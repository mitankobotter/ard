$Host.UI.RawUI.WindowTitle = 'ATtiny85 Pro Blackjack'
[Console]::BackgroundColor = 'DarkBlue'
[Console]::ForegroundColor = 'White'
cls

Function Get-Card { return Get-Random -Min 2 -Max 12 }

Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "                ATtiny85 PRO BLACKJACK                          " -ForegroundColor Yellow
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host ""

$balance = Read-Host "Enter your starting bankroll ($)"
$balance = [int]$balance

while ($balance -gt 0) {
    Write-Host "----------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host " Current Balance: `$$balance" -ForegroundColor Yellow
    
    $bet = Read-Host "Enter your bet amount (or type 0 to quit)"
    $bet = [int]$bet
    if ($bet -le 0) { break }
    if ($bet -gt $balance) {
        Write-Host "You don't have enough balance for that bet!" -ForegroundColor Red
        continue
    }

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
                [Console]::Beep(200, 500) # Low pitch beep for half a second
                $balance -= $bet
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
            [Console]::Beep(800, 500) # High pitch beep for half a second
            $balance += $bet
        } elseif ($dSum -eq $pSum) {
            Write-Host "PUSH (Tie)." -ForegroundColor Yellow
        } else {
            Write-Host "DEALER WINS!" -ForegroundColor Red
            [Console]::Beep(200, 500) # Low pitch beep for loss
            $balance -= $bet
        }
    }
    Write-Host ""
}

Write-Host "================================================================" -ForegroundColor Cyan
Write-Host " Game Over! Final Balance: `$$balance" -ForegroundColor Yellow
Write-Host "================================================================" -ForegroundColor Cyan
Read-Host "Press Enter to close window"
