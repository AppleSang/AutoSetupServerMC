$xml = @"
<toast launch="action=viewFriendRequest&amp;userId=49183", activationType="protocol" launch="https://www.google.com/">
  <visual>
    <binding template="ToastGeneric">
      <text>=-Welcome To AppleAutoServer-=</text>
      <text>Made By AppleSang and thenoppy12</text>
      <text>!! Script Vẫn Trong Giai Đoạn Beta !! </text>
      <image placement="appLogoOverride" src="$env:temp\apple.gif"/>
      <image placement="hero" src="$env:temp\frog.gif"/>
    </binding>
  </visual>
  
  <actions>
    <action content="Join Discord Server" activationType="protocol" arguments="https://dsc.gg/wrc" />
    <action content="Owner Project" activationType="protocol" arguments="https://discord.com/users/832102836694941707" />
  </actions>
</toast>
"@
$XmlDocument = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]::New()
$XmlDocument.loadXml($xml)
$AppId = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]::CreateToastNotifier($AppId).Show($XmlDocument)

$MediaPlayer = [Windows.Media.Playback.MediaPlayer, Windows.Media, ContentType = WindowsRuntime]::New()
$MediaPlayer.Source = [Windows.Media.Core.MediaSource]::CreateFromUri('https://cdn.pixabay.com/download/audio/2022/03/20/audio_90d59efbe6.mp3?filename=computer-startup-music-97699.mp3')
$MediaPlayer.Play()
