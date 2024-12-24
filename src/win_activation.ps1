function Set-WindowsActivation {
    Write-Host "WARNING: USE AT YOUR OWN RISK" -ForegroundColor Yellow
    Write-Host "I AM NOT RESPONSIBLE FOR ANY DAMAGES" -ForegroundColor Red

    $response = Read-Host "Would you like to continue? [Y/N]"
    if ($response -notmatch "^[Yy]$") {
        Write-Host "Exiting activation process..." -ForegroundColor Cyan
        return
    }

    $productKeys = @{
        1 = "TX9XD-98N7V-6WMQ6-BX7FG-H8Q99"
        2 = "3KHY7-WNT83-DGQKR-F7HPR-844BM"
        3 = "7HNRX-D7KGG-3K4RQ-4WPJ4-YTDFH"
        4 = "PVMJN-6DFY6-9CCP6-7BKTT-D3WVR"
        5 = "W269N-WFGWX-YVC9B-4J6C9-T83GX"
        6 = "MH37W-N47XK-V7XM9-C7227-GCQG9"
        7 = "NRG8B-VKK3Q-CXVCJ-9G2XF-6Q84J"
        8 = "9FNHH-K3HBT-3W4TD-6383H-6XYWF"
        9 = "6TP4R-GNPTD-KYYHQ-7B7DP-J447Y"
        10 = "YVWGF-BXNMC-HTQYQ-CPQ99-66QFC"
        11 = "NW6C2-QMPVW-D7KKK-3GKT6-VCFB2"
        12 = "2WH4N-8QGBV-H22JP-CT43Q-MDWWJ"
        13 = "NPPR9-FWDCX-D2C8J-H872K-2YT43"
        14 = "DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4"
        15 = "YYVX9-NTFWV-6MDM3-9PT4T-4M68B"
        16 = "44RPN-FTY23-9VTTB-MP9BX-T84FV"
        17 = "M7XTQ-FN8P6-TTKYV-9D4CC-J462D"
        18 = "92NFX-8DJQP-P6BBQ-THF9C-7CG2H"
    }

    while ($true) {
        Write-Host "Select Your Operating System to Activate:"
        Write-Host "1. Home"
        Write-Host "2. Home N"
        Write-Host "3. Home Single Language"
        Write-Host "4. Home Country Specific"
        Write-Host "5. Pro"
        Write-Host "6. Pro N"
        Write-Host "7. Pro for Workstations"
        Write-Host "8. Pro for Workstations N"
        Write-Host "9. Pro Education"
        Write-Host "10. Pro Education N"
        Write-Host "11. Education"
        Write-Host "12. Education N"
        Write-Host "13. Enterprise"
        Write-Host "14. Enterprise N"
        Write-Host "15. Enterprise G"
        Write-Host "16. Enterprise G N"
        Write-Host "17. Enterprise LTSC 2019"
        Write-Host "18. Enterprise N LTSC 2019"
        Write-Host "19. Exit"

        $osChoice = Read-Host "Enter your choice (1-19)"
        if ($osChoice -eq 19) {
            Write-Host "Exiting activation process..." -ForegroundColor Cyan
            break
        }

        if (-not $productKeys.ContainsKey($osChoice)) {
            Write-Host "Invalid choice. Please try again." -ForegroundColor Red
            Start-Sleep -Seconds 2
            continue
        }

        $productKey = $productKeys[$osChoice]
        Write-Host "Applying product key: $productKey" -ForegroundColor Green

        try {
            Start-Process -FilePath "cscript" -ArgumentList "slmgr.vbs /ipk $productKey" -NoNewWindow -Wait
            Start-Process -FilePath "cscript" -ArgumentList "slmgr.vbs /skms kms8.msguides.com" -NoNewWindow -Wait
            Start-Process -FilePath "cscript" -ArgumentList "slmgr.vbs /ato" -NoNewWindow -Wait
            Write-Host "Activation complete!" -ForegroundColor Green
        } catch {
            Write-Host "An error occurred during activation." -ForegroundColor Red
        }

        $exitResponse = Read-Host "Would you like to quit the activation process? [Y/N]"
        if ($exitResponse -match "^[Yy]$") {
            Write-Host "Exiting activation process..." -ForegroundColor Cyan
            break
        }
    }
}
