# wslwin
Nasty, brute force way to FINALLY open `explorer` and `vscode` with correct context from WSL. Hooray?

#### Microsoft ain't kiddin' (warnings)
...you're gonna have some bad times when you mess with linux files using windows tools, but what is linux without freedom of choices?! If you want a taste of this badness: make a new file using vscode or explorer inside your linux home directory. This file will be invisible to linux. But hey, you're a poweruser now! You live for this stuff! **But seriously, don't create/delete/copy-into files from vscode or explorer. I've had no issues with editing/browsing/copying-out-of.**

### So what CAN I do with this??? 
I personally have a kivy/python project that is already up and running, and it needs to build android binaries out of linux. I keep all my source in WSL and open vscode and edit from there. Works beautifully. I don't need multiple sym links or aliases, and I don't have to set anything else up to edit code from my WSL using vscode. 

Or say you have files you want to copy from linux to windows using explorer and a GUI, that's a reasonable thing to do now. Or just clicking and browsing file structure. These are all things that I find incredibly annoying that these scripts help to mitigate. 

#### Dependencies
Sadly, this uses python 3 at the moment. You need to install it with `sudo apt install python3`

(This shouldn't be necessary in the future, as the things in this repo can (theoretically) be done purely with bash scripting. I have a `workinprogress.sh` file here for people to help me out with finishing it, but that file can be ignored for now otherwise.)

### Installation
In your WSL (Linux) distro: 
```
cd
git clone https://github.com/andymule/wslwin.git
```

Browse to this location in windows (using the gross method you're exactly replacing with this repo) mine is here:

`C:\Users\<myname>\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\rootfs\home\<myname>\wslwin\`

and right-click `setWSLENV.ps1` and `Run With Powershell` (if you don't see this context, it's because you've changed default programs for opening ps1 files. you'll need to shift+right-click>"open powershell window here" and type ./setWSLENV.ps1)

If you're having trouble running this powershell file, you probably need to first set your computer to run powershell files by opening a powershell as admin and running `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned` as defined by Microsoft [here](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-6)

This sets up the  C:\ default linux installation location of your WSLENV environment variable so linux can see it and use it. 

Now, in linux, browse into this repo (mine is ~/wslwin) and run `sudo ./install.sh`

You did it!

## Usage
from ANYWHERE in linux:

`explorer` opens a windows explorer at your current location

`vscode` opens vscode in your current folder

`vscode [filename]` opens vscode file at that location, first creating the file in linux if it doesn't exist
