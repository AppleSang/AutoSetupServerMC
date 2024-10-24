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
    </binding>
  </visual>

  <actions>

    <action
      activationType="background"
      arguments="action=pauseDownload&amp;downloadId=9438108"
      content="A"/>

    <action
      activationType="background"
      arguments="action=cancelDownload&amp;downloadId=9438108"
      content="Cancel"/>
    
  </actions>
  
</toast>
"@
$XmlDocument = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]::New()
$XmlDocument.loadXml($xml)
$ToastNotification = [Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime]::New($XmlDocument)
$ToastNotification.Tag = 'my_tag'
$Dictionary = [System.Collections.Generic.Dictionary[String, String]]::New()
$Dictionary.Add('progressTitle', 'YouTube')
$Dictionary.Add('progressValue', '0')
$Dictionary.Add('progressValueString', '0/15 videos')
$Dictionary.Add('progressStatus', 'Downloading...')
$ToastNotification.Data = [Windows.UI.Notifications.NotificationData]::New($Dictionary)
$ToastNotification.Data.SequenceNumber = 1
$AppId = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]::CreateToastNotifier($AppId).Show($ToastNotification)


for ($index = 1; $index -le 15; $index++) {
  Start-Sleep 1
  $Dictionary = [System.Collections.Generic.Dictionary[String, String]]::New()
  $Dictionary.Add('progressValue', $index / 15)
  $Dictionary.Add('progressValueString', "$index/15 videos")
  $NotificationData = [Windows.UI.Notifications.NotificationData]::New($Dictionary)
  $NotificationData.SequenceNumber = 2
  [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Update($NotificationData, 'my_tag')
}

$Dictionary = [System.Collections.Generic.Dictionary[String, String]]::New()
$Dictionary.Add('progressStatus', 'Completed!')
$NotificationData = [Windows.UI.Notifications.NotificationData]::New($Dictionary)
$NotificationData.SequenceNumber = 2
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Update($NotificationData, 'my_tag')
