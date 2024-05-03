$basePath = "C:\krass\personal\AHK"
$exeFiles = Get-ChildItem -Path $basePath -File -Filter "*.exe"

foreach ($exeFile in $exeFiles) {
    $filePath = $exeFile.FullName
    Start-Process -FilePath $filePath
}
