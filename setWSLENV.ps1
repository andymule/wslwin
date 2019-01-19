#request admin rights so we can set the WSLENV environment variable we need in linux

$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal = new-object System.Security.Principal.WindowsPrincipal($myWindowsID) 
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator
# Check to see if we are currently running "as Administrator"
if ($myWindowsPrincipal.IsInRole($adminRole)) {
    # We are running "as Administrator" - so change the title and background color to indicate this
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)"
    $Host.UI.RawUI.BackgroundColor = "DarkBlue"
    clear-host
}
else {
    # We are not running "as Administrator" - so relaunch as administrator
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
    $newProcess.Arguments = $myInvocation.MyCommand.Definition;
    $newProcess.Verb = "runas";
    [System.Diagnostics.Process]::Start($newProcess);
    # Exit from the current, unelevated, process
    exit
}
 
Try {
    # This code should be running with admin elevation
    $username = $env:username
    $appPackages = "C:\Users\" + $username + "\AppData\Local\Packages"

    [Console]::OutputEncoding = [System.Text.Encoding]::Unicode
    $linuxs = wslconfig.exe /l
    $defaultdistro = $linuxs | Select-String -Pattern "Default" -CaseSensitive 
    $defaultdistro = $defaultdistro -split '\s+'
    $defaultdistro = $defaultdistro[0]
    $linuxPackage = ls $appPackages *$defaultdistro* -Directory
    $linuxPackage = $linuxPackage -split '\s+'
    $linuxRoot = $appPackages + "\" + $linuxPackage + "\LocalState\rootfs"

    #linux-ize the path
    $linuxRoot = $linuxRoot -replace "\\", "\"

    [Environment]::SetEnvironmentVariable("WSLENV", $linuxRoot, "Machine")

    Write-Host "WSLENV set successfully! Windows-side of the setup is complete."  -ForegroundColor Green
    Write-Output "Press a key to close"
}
Catch {
    Write-Error "Ran into an issue: $($PSItem.ToString())"
    Write-Output ""
    Write-Output "Setting WSLENV failed, sorry sis."
}
cmd /c pause | out-null