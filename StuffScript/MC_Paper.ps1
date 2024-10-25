# Define the API URL
$apiUrl = "https://api.papermc.io/v2/projects/paper"

# Fetch the JSON data from the API
$response = Invoke-RestMethod -Uri $apiUrl

# Display available versions
Write-Host "Hiện Tại Đang Có Những Phiên Bản Sau:"
for ($i = 0; $i -lt $response.versions.Count; $i++) {
    Write-Host "$($i + 1): $($response.versions[$i])"
}

# Prompt user to select a version
$versionIndex = Read-Host "Select a version number to download"
$selectedVersion = $response.versions[$versionIndex - 1]

# Fetch builds for the selected version
$buildsUrl = "https://api.papermc.io/v2/projects/paper/versions/$selectedVersion/builds"
$buildsResponse = Invoke-RestMethod -Uri $buildsUrl

# Get the latest build number (only the "build" value)
$latestBuild = $buildsResponse.builds[-1].build

# Construct the download URL using the latest build number
$downloadUrl = "https://api.papermc.io/v2/projects/paper/versions/$selectedVersion/builds/$latestBuild/downloads/paper-$selectedVersion-$latestBuild.jar"

# Download the paper.jar file
Invoke-WebRequest -Uri $downloadUrl -OutFile "server.jar"

Write-Host "Bạn Đã Tải $selectedVersion, Với Bản Build $latestBuild"
