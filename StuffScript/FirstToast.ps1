$xml = @"
<toast scenario="incomingCall">
  
  <visual>
    <binding template="ToastGeneric">
      <text>=-Welcome To AppleAutoServer-=</text>
      <text>Script Tạo Máy Chủ Minecraft Tự Động</text>
      <text>!! Script Vẫn Trong Giai Đoạn Beta !! </text>
      <image placement="appLogoOverride" src="$env:temp\apple.gif"/>
      <image placement="hero" src="$env:temp\frog.gif"/>
    </binding>
  </visual>
  
  <actions>
    <action content="Join Discord Server" activationType="protocol" arguments="https://dsc.gg/wrc" />
  </actions>
</toast>
"@
$XmlDocument = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]::New()
$XmlDocument.loadXml($xml)
$AppId = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]::CreateToastNotifier($AppId).Show($XmlDocument)

$MediaPlayer = [Windows.Media.Playback.MediaPlayer, Windows.Media, ContentType = WindowsRuntime]::New()
$MediaPlayer.Source = [Windows.Media.Core.MediaSource]::CreateFromUri('https://github.com/AppleSang/AutoSetupServerMC/raw/refs/heads/master/StuffScript/Dopamine-Streambeat_Short.mp3')
$MediaPlayer.Play()
