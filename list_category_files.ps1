param([string]$cat)
$enc = [System.Uri]::EscapeDataString("Category:$cat")
$url = "https://commons.wikimedia.org/w/api.php?action=query&list=categorymembers&cmtitle=$enc&cmtype=file&cmlimit=15&format=json"
try {
    Start-Sleep -Milliseconds 600
    $r = Invoke-WebRequest -Uri $url -UseBasicParsing -UserAgent 'WhereToNextZim/1.0 (info@wtnz.co.zw)'
    $j = ConvertFrom-Json $r.Content
    foreach ($item in $j.query.categorymembers) {
        $t = $item.title.Replace("File:", "")
        $cleanEnc = [System.Uri]::EscapeDataString($t)
        Write-Output "https://commons.wikimedia.org/wiki/Special:FilePath/$cleanEnc"
    }
} catch {
    Write-Output "ERR: $($_.Exception.Message)"
}
