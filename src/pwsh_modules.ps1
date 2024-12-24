#
## Windows PowerShell
### PowerShell Modules Installation
#

function Install-PowerShellModules {
    Write-Host "Installing PowerShell Modules..."
    Install-Module -Name Terminal-Icons -Repository PSGallery -Force
    Write-Host "The installation of the modules is complete."
}