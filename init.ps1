#
## Windows PowerShell
### Main Menu and Initialization
#

. .\winget.ps1
. .\pwsh_modules.ps1
. .\wsl.ps1

function Show-Menu {
    Write-Host "Select an action:"
    Write-Host "1. Install applications via Winget"
    Write-Host "2. Install WSL"
    Write-Host "3. Install PowerShell Modules"
    Write-Host "0. Exit"
}

do {
    Show-Menu
    $choice = Read-Host "Enter the action number"

    switch ($choice) {
        "1" { Install-WingetApps }
        "2" { Install-WSL }
        "3" { Install-PowerShellModules }
        "0" { Write-Host "Exit from the program."; break }
        default { Write-Host "Wrong choice, try again." }
    }
} while ($choice -ne "0")
