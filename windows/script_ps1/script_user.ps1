$installEssentialApplications
$changeBackgorund
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

Set-ExecutionPolicy AllSigned

function InstallEssentialApplications {
    Write-Host "Installing Slack"
    winget install SlackTechnologies.Slack --force
    Write-Host "Installed Slack"

    Write-Host "Uninstall OneDrive"
    taskkill /f /im OneDrive.exe
    cmd -c "%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall"
    Write-Host "OneDrive Uninstalled"

    Write-Host "Uninstall DriverBooster"
    winget uninstall IObit.DriverBooster9 --silent
    Write-Host "Uninstall DriverBooster"
    
    Write-Host "Uninstall Skype"
    winget uninstall Microsoft.Skype --silent
    Write-Host "Uninstall Skype"


}

function changeBackgorund{
    Write-Host "Setting background"
    cp D:\configuracao\backgroundPictures\BackgroundBoasVindas1.png $env:USERPROFILE\Pictures\
    timeout 5
    powershell.exe .\Set-background.ps1
    Write-Host "Background OK!"
}

$changeBackgorund = Read-Host "Would you like Change Background (Y/N)?"
if ($changeBackgorund -eq "Y") {
    changeBackgorund
}
