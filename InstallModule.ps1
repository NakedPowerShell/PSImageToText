$ModuleName = 'PSImageToText'
$ModulePath = 'C:\Program Files\WindowsPowerShell\Modules'

$TargetPath = Join-Path -Path $ModulePath -ChildPath $ModuleName

Remove-Item $TargetPath -Recurse -Force -ErrorAction Ignore

if (-not (Test-Path $TargetPath)) {
    New-Item -Path $TargetPath -ItemType Directory -EA Stop | Out-Null
    #Write-Verbose "$ModuleName created module folder '$TargetPath'"
}

Copy-Item .\PSImageToText.psd1 $TargetPath
Copy-Item .\PSImageToText.psm1 $TargetPath
Copy-Item .\README.md $TargetPath