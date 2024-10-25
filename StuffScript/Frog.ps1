$MediaPlayer = [Windows.Media.Playback.MediaPlayer, Windows.Media, ContentType = WindowsRuntime]::New()
$MediaPlayer.Source = [Windows.Media.Core.MediaSource]::CreateFromUri('https://github.com/AppleSang/AutoSetupServerMC/raw/refs/heads/master/StuffScript/Dopamine-Streambeat.mp3')
$MediaPlayer.Play()
$xml = @"
<toast launch="action=viewDownload&amp;downloadId=9438108">
  
  <visual>
    <binding template="ToastGeneric">
      <text>Dopamine</text>
      <progress
        title="{progressTitle}"
        value="{progressValue}"
        valueStringOverride="{progressValueString}"
        status="{progressStatus}"/>
        <image src="$env:temp\frog.gif"/>
    </binding>
  </visual>

  <actions>

    <action
      activationType="protocol"
      arguments="https://open.spotify.com/track/2AeKeS6smAVNXadfjEO7z0?si=d7e3dcfc195941d3"
      content="Songs On Spotify"/>

    <action
      activationType="protocol"
      arguments="https://dsc.gg/wrc"
      content="Support Us"/>
    
  </actions>
  
</toast>
"@
$XmlDocument = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]::New()
$XmlDocument.loadXml($xml)
$ToastNotification = [Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime]::New($XmlDocument)
$ToastNotification.Tag = 'my_tag'
$Dictionary = [System.Collections.Generic.Dictionary[String, String]]::New()
$Dictionary.Add('progressTitle', 'StreamBeats by Harris Heller')
$Dictionary.Add('progressValue', '0:00')
$Dictionary.Add('progressValueString', '')
$Dictionary.Add('progressStatus', '0:00')
$ToastNotification.Data = [Windows.UI.Notifications.NotificationData]::New($Dictionary)
$ToastNotification.Data.SequenceNumber = 1
$AppId = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]::CreateToastNotifier($AppId).Show($ToastNotification)


for ($index = 1; $index -le 131; $index++) {
  Start-Sleep 1
  $Dictionary = [System.Collections.Generic.Dictionary[String, String]]::New()
  $Dictionary.Add('progressValue', $index / 131)
  $Dictionary.Add('progressValueString', "2:11")
  $NotificationData = [Windows.UI.Notifications.NotificationData]::New($Dictionary)
  $NotificationData.SequenceNumber = 2
  [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Update($NotificationData, 'my_tag')
}

$Dictionary = [System.Collections.Generic.Dictionary[String, String]]::New()
$Dictionary.Add('progressStatus', 'Hết Bài Nhạc Rùi')
$NotificationData = [Windows.UI.Notifications.NotificationData]::New($Dictionary)
$NotificationData.SequenceNumber = 2
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Update($NotificationData, 'my_tag')
