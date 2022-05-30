$changeBackgorund

function changeBackgorund{
    Write-Host "Setting background"
    cp D:\configuracao\backgroundPictures\BackgroundBoasVindas1.png $env:USERPROFILE\Pictures\
    powershell.exe .\Set-background.ps1
    Write-Host "Background OK!"
}

$changeBackgorund = Read-Host "Would you like Change Background (Y/N)?"
if ($changeBackgorund -eq "Y") {
    changeBackgorund
}