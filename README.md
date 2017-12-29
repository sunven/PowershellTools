# PowershellTools

## 快捷删除obj方便调试

### 使用

- 直接运行或以管理员身份运行`delobj.bat`

### 说明

- 由于obj可能会被应用程序占用，所以会先停应用程序池，再删obj，再启应用程序池
- 默认`delobj.bat`和`delobj.ps1`需在同一个目录
-  为了管理员权限才使用`delobj.bat`调用`delobj.ps1`，所以`delobj.ps1`可独立使用
- 应用程序池名称和obj路径可自行在`delobj.ps1`中配置