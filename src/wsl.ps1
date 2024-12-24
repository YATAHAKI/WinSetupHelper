#
## Windows PowerShell
### WSL Installation
#

function Check-WSLFeatures {
    Write-Host "Checking if the required Windows features for WSL are enabled..."

    $wslFeature = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    $vmPlatform = Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform

    if ($wslFeature.State -eq "Enabled") {
        Write-Host "The WSL feature is enabled." -ForegroundColor Green
    } else {
        Write-Host "The WSL feature is not enabled." -ForegroundColor Yellow
    }

    if ($vmPlatform.State -eq "Enabled") {
        Write-Host "The Virtual Machine Platform feature is enabled." -ForegroundColor Green
    } else {
        Write-Host "The Virtual Machine Platform feature is not enabled." -ForegroundColor Yellow
    }

    return ($wslFeature.State -eq "Enabled" -and $vmPlatform.State -eq "Enabled")
}

function Check-WSLReadiness {
    $featuresCheck = Check-WSLFeatures

    if ($featuresCheck) {
        Write-Host "The system is ready for WSL installation." -ForegroundColor Green
        return $true
    } else {
        Write-Host "The system is not ready for WSL installation." -ForegroundColor Red
        return $false
    }
}

function Show-WSLDistributionList {
    Write-Host "Fetching available WSL distributions..."
    $distributions = wsl -l -o
    $distributions | ForEach-Object { Write-Host "$($_)" }
}

function Install-WSL {
    Write-Host "Checking if the system is ready for WSL installation..."
    $ready = Check-WSLReadiness
    if ($ready) {
        Write-Host "System is ready for WSL installation."
        Show-WSLDistributionList
        
        $chosenDistro = Read-Host "Enter the name of the distribution to install"
        
        Write-Host "Installing $chosenDistro..."
        wsl --install -d $chosenDistro
        Write-Host "$chosenDistro has been installed successfully."
    } else {
        Write-Host "The system is not ready for WSL installation. Please enable required features."
    }
}