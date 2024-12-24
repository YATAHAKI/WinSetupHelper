#
## Windows PowerShell
### Winget Applications Installation
#

function Install-WingetApps {
    $apps = @(
        "Git.Git",
        "RadolynLabs.AyuGramDesktop",
        "ShareX.ShareX",
        "7zip.7zip",
        "qBittorrent.qBittorrent",
        "JetBrains.Toolbox",
        "Postman.Postman",
        "Microsoft.VisualStudioCode",
        "Microsoft.VisualStudio.2022.Enterprise",
        "DEVCOM.JetBrainsMonoNerdFont",
        "Vencord.Vesktop",
        "chocolatey.chocolatey"
    )

    Write-Host "Available applications to install (enter the numbers to exclude):"
    $apps | ForEach-Object { Write-Host "$($apps.IndexOf($_) + 1). $_" }

    $selectedIndexes = Read-Host "Enter the numbers of apps to exclude (comma separated)"
    $selectedIndexes = $selectedIndexes -split "," | ForEach-Object { [int]$_ - 1 }

    $appsToInstall = $apps | Where-Object { $apps.IndexOf($_) -notin $selectedIndexes }

    if ($appsToInstall.Count -gt 0) {
        Write-Host "`nThe following applications will be installed:"
        $appsToInstall | ForEach-Object { Write-Host "$($_)" }

        foreach ($app in $appsToInstall) {
            Write-Host "`nInstalling $app..."
            winget install -e --id $app --source winget
            if ($?) {
                Write-Host "$app installed successfully." -ForegroundColor Green
            } else {
                Write-Host "Failed to install $app." -ForegroundColor Red
            }
        }

        Write-Host "`nApplication installation is complete."
    } else {
        Write-Host "`nNo applications were selected for installation."
    }
}
