$xml = @"
<toast launch="action=viewDownload&amp;downloadId=9438108">
  
  <visual>
    <binding template="ToastGeneric">
      <text>Đang Tải Các Dữ Liệu Cần Thiết! </text>
      <progress
        title="{progressTitle}"
        value="{progressValue}"
        valueStringOverride="{progressValueString}"
        status="{progressStatus}"/>
        <image src="$env:temp\look.gif"/>
    </binding>
  </visual>

  <actions>

    <action
      activationType="protocol"
      arguments="https://discord.com/users/1086149348414464041"
      content="Dev Support Project"/>

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
$Dictionary.Add('progressTitle', 'Hãy Chờ Đợi Tải Và Chạy Các Thứ Cơ Bản')
$Dictionary.Add('progressValue', '0')
$Dictionary.Add('progressValueString', '0%/100% File Server')
$Dictionary.Add('progressStatus', $info)
$ToastNotification.Data = [Windows.UI.Notifications.NotificationData]::New($Dictionary)
$ToastNotification.Data.SequenceNumber = 1
$AppId = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]::CreateToastNotifier($AppId).Show($ToastNotification)


for ($index = 1; $index -le 100; $index++) {
  Start-Sleep 1
  $Dictionary = [System.Collections.Generic.Dictionary[String, String]]::New()
  $Dictionary.Add('progressValue', $index / 100)
  $Dictionary.Add('progressValueString', "$index%/ 100%")
  $NotificationData = [Windows.UI.Notifications.NotificationData]::New($Dictionary)
  $NotificationData.SequenceNumber = 2
  [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Update($NotificationData, 'my_tag')
}

$Dictionary = [System.Collections.Generic.Dictionary[String, String]]::New()
$Dictionary.Add('progressStatus', 'Đã Xong Rồi!')
$NotificationData = [Windows.UI.Notifications.NotificationData]::New($Dictionary)
$NotificationData.SequenceNumber = 2
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Update($NotificationData, 'my_tag')


$MediaPlayer = [Windows.Media.Playback.MediaPlayer, Windows.Media, ContentType = WindowsRuntime]::New()
$MediaPlayer.Source = [Windows.Media.Core.MediaSource]::CreateFromUri('https://github.com/AppleSang/AutoSetupServerMC/raw/refs/heads/master/StuffScript/Dopamine-Streambeat_Short.mp3')
$MediaPlayer.Play()
