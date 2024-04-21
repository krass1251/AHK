$basePath = "C:\krass\personal\krass-lib\AutoHotkey"
$exeFiles = Get-ChildItem -Path $basePath -File -Filter "*.exe"

foreach ($exeFile in $exeFiles) {
    $filePath = $exeFile.FullName
    Start-Process -FilePath $filePath
}
