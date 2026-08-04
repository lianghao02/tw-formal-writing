$files = @(
    "C:\Users\chia-hao\Downloads\115年7月第4週各級督導人員優、缺點、問題與建議督導通報.docx",
    "C:\Users\chia-hao\Downloads\115年6月第5週、7月第1週高司、各科、室、中心、直屬大隊（隊）正（副）主官督導通報.docx",
    "C:\Users\chia-hao\Downloads\115年7月第2週高司、各科、室、中心、直屬大隊（隊）正（副）主官督導通報.docx",
    "C:\Users\chia-hao\Downloads\115年7月第3週高司、各科、室、中心、直屬大隊（隊）正（副）主官督導通報.docx",
    "C:\Users\chia-hao\Downloads\115年7月第4週高司、各科、室、中心、直屬大隊（隊）正（副）主官督導通報.docx",
    "C:\Users\chia-hao\Downloads\115年6月第5週、7月第1週各級督導人員優、缺點、問題與建議督導通報.docx",
    "C:\Users\chia-hao\Downloads\115年7月第2週各級督導人員優、缺點、問題與建議督導通報.docx",
    "C:\Users\chia-hao\Downloads\115年7月第3週各級督導人員優、缺點、問題與建議督導通報.docx",
    "C:\Users\chia-hao\Downloads\督導報告 (4).docx",
    "C:\Users\chia-hao\Downloads\督導報告 (3).docx",
    "C:\Users\chia-hao\Downloads\督導報告 (2).docx",
    "C:\Users\chia-hao\Downloads\督導報告 (1).docx",
    "C:\Users\chia-hao\Downloads\督導報告.docx"
)

Add-Type -AssemblyName System.IO.Compression.FileSystem

$outFile = "C:\Users\chia-hao\Documents\GitHub\tw-formal-writing\extracted_docs.txt"
if (Test-Path $outFile) { Remove-Item $outFile }

foreach ($f in $files) {
    "============================================================" | Out-File -FilePath $outFile -Append -Encoding utf8
    "FILE: $(Split-Path $f -Leaf)" | Out-File -FilePath $outFile -Append -Encoding utf8
    "============================================================" | Out-File -FilePath $outFile -Append -Encoding utf8

    if (-not (Test-Path $f)) {
        "[File Not Found: $f]" | Out-File -FilePath $outFile -Append -Encoding utf8
        continue
    }

    try {
        $zip = [System.IO.Compression.ZipFile]::OpenRead($f)
        $entry = $zip.Entries | Where-Object { $_.FullName -eq "word/document.xml" }
        if ($entry) {
            $stream = $entry.Open()
            $reader = New-Object System.IO.StreamReader($stream)
            $xmlText = $reader.ReadToEnd()
            $reader.Close()
            $stream.Close()

            $xml = [xml]$xmlText
            # Extract text elements
            $textNodes = $xml.SelectNodes("//*[local-name()='t']")
            $sb = New-Object System.Text.StringBuilder
            foreach ($node in $textNodes) {
                [void]$sb.Append($node.InnerText)
            }
            $sb.ToString() | Out-File -FilePath $outFile -Append -Encoding utf8
        }
        $zip.Dispose()
    } catch {
        "Error: $_" | Out-File -FilePath $outFile -Append -Encoding utf8
    }
    "`n`n" | Out-File -FilePath $outFile -Append -Encoding utf8
}

Write-Host "Done! Saved to $outFile"
