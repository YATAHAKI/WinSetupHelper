#
## Windows PowerShell
### Windows Defender Remover
#

function Remove-WindowsDefender {
    $remove_appx = @("SecHealthUI")
    $provisioned = Get-AppxProvisionedPackage -Online
    $appxpackage = Get-AppxPackage -AllUsers
    $eol = @()
    $store = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore'
    $users = @('S-1-5-18')

    if (Test-Path $store) {
        $users += $((Dir $store -Ea 0 | Where-Object { $_ -Like '*S-1-5-21*' }).PSChildName)
    }

    foreach ($choice in $remove_appx) {
        if ('' -eq $choice.Trim()) {
            continue
        }

        foreach ($appx in $provisioned | Where-Object { $_.PackageName -Like "*$choice*" }) {
            $next = $false
            foreach ($no in $skip) {
                if ($appx.PackageName -Like "*$no*") {
                    $next = $true
                }
            }

            if ($next) { continue }

            $PackageName = $appx.PackageName
            $PackageFamilyName = ($appxpackage | Where-Object { $_.Name -eq $appx.DisplayName }).PackageFamilyName
            New-Item "$store\Deprovisioned\$PackageFamilyName" -Force | Out-Null
            Write-Host "Removing Package: $PackageFamilyName"
            foreach ($sid in $users) {
                New-Item "$store\EndOfLife\$sid\$PackageName" -Force | Out-Null
            }
            $eol += $PackageName
            dism /Online /Set-NonRemovableAppPolicy /PackageFamily:$PackageFamilyName /NonRemovable:0 | Out-Null
            Remove-AppxProvisionedPackage -PackageName $PackageName -Online -AllUsers | Out-Null
        }

        foreach ($appx in $appxpackage | Where-Object { $_.PackageFullName -Like "*$choice*" }) {
            $next = $false
            foreach ($no in $skip) {
                if ($appx.PackageFullName -Like "*$no*") {
                    $next = $true
                }
            }

            if ($next) { continue }

            $PackageFullName = $appx.PackageFullName
            New-Item "$store\Deprovisioned\$appx.PackageFamilyName" -Force | Out-Null
            Write-Host "Removing Package: $PackageFullName"
            foreach ($sid in $users) {
                New-Item "$store\EndOfLife\$sid\$PackageFullName" -Force | Out-Null
            }
            $eol += $PackageFullName
            dism /Online /Set-NonRemovableAppPolicy /PackageFamily:$PackageFamilyName /NonRemovable:0 | Out-Null
            Remove-AppxPackage -Package $PackageFullName -AllUsers | Out-Null
        }
    }
}