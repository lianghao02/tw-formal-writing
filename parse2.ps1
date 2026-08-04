Add-Type -AssemblyName System.IO.Compression.FileSystem

$dir = "C:\Users\chia-hao\Downloads"
$files = Get-ChildItem -Path $dir -Filter "*.docx" | Where-Object { $_.Name -like "*督導*" }

$outFile = "C:\Users\chia-hao\Documents\GitHub\tw-formal-writing\extracted_docs.txt"
if (Test-Path $outFile) { Remove-Item $outFile }

foreach ($fileItem in $files) {
    $f = $fileItem.FullName
    "============================================================" | Out-File -FilePath $outFile -Append -Encoding utf8
    "FILE: $($fileItem.Name)" | Out-File -FilePath $outFile -Append -Encoding utf8
    "============================================================" | Out-File -FilePath $outFile -Append -Encoding utf8

    try {
        $zip = [System.IO.Compression.ZipFile]::OpenRead($f)
        $entry = $zip.Entries | Where-Object { $_.FullName -eq "word/document.xml" }
        if ($entry) {
            $stream = $entry.Open()
            $reader = New-Object System.IO.StreamReader($stream, [System.Text.Encoding]::UTF8)
            $xmlText = $reader.ReadToEnd()
            $reader.Close()
            $stream.Close()

            $xml = [xml]$xmlText
            $textNodes = $xml.SelectNodes("//*[local-name()='t']")
            $sb = New-Object System.Text.StringBuilder
            foreach ($node in $textNodes) {
                [void]$sb.Append($node.InnerText)
                [void]$sb.Append(" ")
            }
            $sb.ToString() | Out-File -FilePath $outFile -Append -Encoding utf8
        }
        $zip.Dispose()
    } catch {
        "Error: $_" | Out-File -FilePath $outFile -Append -Encoding utf8
    }
    "`n`n" | Out-File -FilePath $outFile -Append -Encoding utf8
}

Write-Host "Processed $($files.Count) files! Saved to $outFile"
