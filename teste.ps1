$InstallEssentialApplications
#$UpdateWindows

Write-Host "Checking if Winget is installed"
Out-Null
if (Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe) {
    "Winget is already installed"
} else {
    # Install Winget
    Write-Host "Winget was not detected. Installing Winget now..."
    Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
    $nid = (Get-Process AppInstaller).Id
    Wait-Process -Id $nid
    Write-Host "Winget installed"
}
timeout 10

function InstallEssentialApplications {
    Write-Host "Installing AnyDesk"
    winget install anydesk
    Write-Host "Installed AnyDesk"

    Write-Host "Install OpenVPN Connect"
    winget install -e --id OpenVPNTechnologies.OpenVPNConnect
    Write-Host "Installed OpenVPN Connect"

    $choice = Read-Host "Install OpenVPN GUI (Y/N)?"
    if ($choice -eq "Y") {
        Write-Host "Install OpenVPN Gui"
        winget install -e --id OpenVPNTechnologies.OpenVPN
        Write-Host "Installed OpenVPN Gui"
    }

    Write-Host "Install Slack"
    winget install -e --id SlackSetup
    Write-Host "Installed Slack"
    
    Write-Host "Install DriverBooster"
    winget install IObit.DriverBooster9
    Write-Host "Install DriverBooster"
}

#function WindowsUpdate {
#    $choice = Read-Host "Do you want update windows (Y/N)?"
#    if ($choice -eq "Y"){
#        Install-Module PSWindowsUpdate
#        Write-Host "List to update windows"
#       Get-WindowsUpdate
#       $answer = Read-Host "Update All Windows and reboot (Y/N)?"
#        if($answer -eq "Y"){
#            Write-Host "Updating windows"
#            Get-WindowsUpdate -AcceptAll -Install -AutoReboot
#            Write-Host "Reboot Windows"
#        }else{
#            Write-Host "What update do you want install?(Set the KB)"
#            $kb = Read-Host "Set the KB: "
#            Get-WindowsUpdate -Install -KBArticleID $kb
#        }
#    }else{
#        Write-Host "Ok."
#    }
#}

$InstallEssentialApplications = Read-Host "Would you like to install Essential Applications (Y/N)?"
if ($InstallEssentialApplications -eq "Y") {
    InstallEssentialApplications
}

#Function to update
#WindowsUpdate