## 启动指定的应用程序池
function Start-IISAppPool($poolName) {
    $appPool = get-wmiobject -namespace "root\MicrosoftIISv2" -class "IIsApplicationPool" | where-object {$_.Name -eq "W3SVC/AppPools/$poolName"}
    $appPool.Start()
}
## 停止指定的应用程序池
function Stop-IISAppPool ($poolName) {
    $appPool = get-wmiobject -namespace "root\MicrosoftIISv2" -class "IIsApplicationPool" | where-object {$_.Name -eq "W3SVC/AppPools/$poolName"}
    $appPool.Stop()
}

## 操作
function AppPoolOperation($poolName, $appObjPath) {
    if (!(Test-Path $appObjPath)) {
        Write-Host "$poolName obj 为空`r`n"
        return
    }
    Write-Host "停 $poolName"
    Stop-IISAppPool $poolName
    Write-Host "删 $poolName obj"
    Remove-Item $appObjPath -Recurse -Force
    Write-Host "启 $poolName`r`n"
    Start-IISAppPool $poolName
}

##################################################################################################################################################

$poolNameArray = "Viss.Server.Host", "Viss.Client.Manager", "Viss.Client.Financial", "Viss.Client.CustomerApi"
$appObjPathArray = "C:\Work\DotNetTeamGit\Caad.Viss\Source\Server\Viss.Server.Host\obj", "C:\Work\DotNetTeamGit\Caad.Viss\Source\Client\Viss.Client.Manager\obj", "C:\Work\DotNetTeamGit\Caad.Viss\Source\Client\Viss.Client.Financial\obj", "C:\Work\DotNetTeamGit\Caad.Viss\Source\Client\Viss.Client.CustomerApi\obj"

$tipStr = "`r`n提示：不输为全部,可以组合输入 "
for ($i = 0; $i -lt $poolNameArray.Length; $i++) {
    $poolName = $poolNameArray[$i]
    $tipStr += "【$i】为$poolName "
}

Write-Host $tipStr

$userInput = Read-Host

if ($userInput -eq "") {
    for ($i = 0; $i -lt $poolNameArray.Length; $i++) {
        $userInput += "" + $i
    }
}

for ($i = 0; $i -lt $userInput.Length; $i++) {
    $inti = 0 + $userInput.Substring($i, 1)
    $poolName = $poolNameArray[$inti]
    $appObjPath = $appObjPathArray[$inti]
    AppPoolOperation $poolName $appObjPath
}

Write-Host "`r`n回车键关闭！"

Read-Host