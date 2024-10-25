New-Item -Path "$env:temp" -Name "AppleAsset" -ItemType "directory"
cd $env:temp\AppleAsset
Invoke-WebRequest -Uri 'https://media.tenor.com/MviKulS1NP0AAAAM/minecraft-microsoft.gif' -OutFile 'frog.gif'
Invoke-WebRequest -Uri 'https://media.tenor.com/rXMWQ5ng9t0AAAAi/golden-apple-minecraft.gif' -OutFile 'apple.gif'
Invoke-WebRequest -Uri 'https://media2.giphy.com/media/vsREO0xnzFGEuCH2Nl/200w.gif' -OutFile 'look.gif'
