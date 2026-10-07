param([string]$name)
Start-Sleep -Milliseconds 600
$encoded = [System.Uri]::EscapeDataString($name)
$url = "https://commons.wikimedia.org/w/api.php?action=query&list=search&srsearch=$encoded&srnamespace=6&srlimit=3&format=json"
try {
    $r = Invoke-WebRequest -Uri $url -UseBasicParsing -UserAgent 'WhereToNextBot/1.0 (info@wtnz.co.zw)'
    $json = ConvertFrom-Json $r.Content
    if ($json.query.searchinfo.totalhits -gt 0) {
        foreach ($s in $json.query.search) {
            $t = $s.title
            if ($t -notmatch '\.pdf$' -and $t -notmatch '\.webm$' -and $t -notmatch '\.ogg$' -and $t -notmatch 'logo') {
                $fe = [System.Uri]::EscapeDataString($t)
                $u = "https://commons.wikimedia.org/w/api.php?action=query&titles=$fe&prop=imageinfo&iiprop=url&format=json"
                Start-Sleep -Milliseconds 400
                $ir = Invoke-WebRequest -Uri $u -UseBasicParsing -UserAgent 'WhereToNextBot/1.0 (info@wtnz.co.zw)'
                $ij = ConvertFrom-Json $ir.Content
                foreach ($p in $ij.query.pages.PSObject.Properties) {
                    if ($p.Value.imageinfo) {
                        Write-Output "$name`t$t`t$($p.Value.imageinfo[0].url)"
                        return
                    }
                }
            }
        }
    }
    Write-Output "NONE`t$name"
} catch {
    Write-Output "ERROR`t$name`t$($_.Exception.Message)"
}
