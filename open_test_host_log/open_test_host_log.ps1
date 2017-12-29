$hostDirName = "Viss.Server.Host", "Viss.Server.Host2", "Viss.Server.Host3"
$logType = "error", "debug"
$logPath = ""
$today = Get-Date
for ($i = 0; $i -lt $hostDirName.Length; $i++) {
    for ($j = 0; $j -lt $logType.Length; $j++) {
        $logPath += "\\172.16.2.3\PublishWeb\" + $hostDirName[$i] + "\Log\" + $today.ToString('yyyy-MM-dd') + "." + $logType[$j] + ".txt "
    }
    
}
$logPath = $logPath.TrimEnd()
Start-Process "D:\Program Files (x86)\Notepad++\notepad++.exe" $logPath