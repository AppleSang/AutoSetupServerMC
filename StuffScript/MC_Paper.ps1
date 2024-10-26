$regPath = "HKCU\Console"
Set-ItemProperty -Path $regPath -Name "FaceName" -Value "Consolas" -Force
Set-ItemProperty -Path $regPath -Name "FontSize" -Value 200 -Force
Set-ItemProperty -Path $regPath -Name "FontWeight" -Value 400 -Force

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8


# Define the API URL for projects
$projectsApiUrl = "https://api.papermc.io/v2/projects"

# Function to validate version selection
function Get-ValidVersionSelection {
    param (
        [array]$versions
    )
    
    while ($true) {
        # Display available versions with numbers
        Write-Host "Đang Có Những Phiên Bản:"
        for ($i = 0; $i -lt $versions.Count; $i++) {
            Write-Host "$($i + 1): $($versions[$i])"
        }

        # Prompt user to select a version
        $selection = Read-Host "Hãy Nhập Số Thứ Tự Để Chọn Phiên Bản $selectedProject (Từ 1->$($versions.Count))"
        
        # Validate if input is a number
        if ($selection -match '^\d+$') {
            $versionIndex = [int]$selection
            
            # Check if selection is within valid range
            if ($versionIndex -ge 1 -and $versionIndex -le $versions.Count) {
                return $versions[$versionIndex - 1]
            }
        }
        cls
        Write-Host "Hình Như Bạn Nhập Sai Số Thứ Tự, Hãy Nhập Lại!"
    }
}

# Main script
while ($true) {
    # Define your project here (e.g., "paper" or "purpur")
    
    
    # Define the API URL for the selected project
    $apiUrl = "$projectsApiUrl/$selectedProject"

    try {
        # Fetch the JSON data for the selected project
        $projectResponse = Invoke-RestMethod -Uri $apiUrl

        # Get valid version selection using the function
        $selectedVersion = Get-ValidVersionSelection -versions $projectResponse.versions

        # Fetch builds for the selected version
        $buildsUrl = "$apiUrl/versions/$selectedVersion/builds"
        $buildsResponse = Invoke-RestMethod -Uri $buildsUrl

        # Get the latest build number
        $latestBuild = $buildsResponse.builds[-1].build

        # Construct the download URL for the latest build
        $downloadUrl = "$apiUrl/versions/$selectedVersion/builds/$latestBuild/downloads/$selectedProject-$selectedVersion-$latestBuild.jar"

        # Download the file
        
        Write-Host "Đang Tải $selectedProject Với Phiên Bản $selectedVersion (build $latestBuild)..."
        cd $env:temp\AppleAsset
        Start-BitsTransfer -Source $downloadUrl -Destination "server.jar"

        Write-Host "Đã Tải $selectedProject-$selectedVersion-$latestBuild.jar Thành Công"
        break  # Exit the loop after successful download
    }
    catch {
        Write-Host "Đã Có Lỗi Xảy Ra: $($_.Exception.Message)"
        Write-Host "Bạn Muốn Chạy Lại Quá Trình Không? (Y/N) "
        $retry = Read-Host
        if ($retry -ne "Y" -and $retry -ne "y") {
            break
        }
    }
}
