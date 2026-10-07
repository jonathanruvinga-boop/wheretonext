param([string[]]$queries)

function Search-Commons([string]$q) {
    Start-Sleep -Milliseconds 500
    $enc = [System.Uri]::EscapeDataString($q)
    $url = "https://commons.wikimedia.org/w/api.php?action=query&list=search&srsearch=$enc&srnamespace=6&srlimit=5&format=json"
    try {
        $r = Invoke-WebRequest -Uri $url -UseBasicParsing -UserAgent 'WhereToNextZim/1.0 (info@wheretonext.co.zw)'
        $j = ConvertFrom-Json $r.Content
        foreach ($item in $j.query.search) {
            $title = $item.title
            if ($title -match '\.(jpe?g|png)$' -and $title -notmatch '(?i)map|flag|coat|stamp|sign|icon|logo|plan|diagram|document') {
                $fe = [System.Uri]::EscapeDataString($title)
                Start-Sleep -Milliseconds 300
                $infoUrl = "https://commons.wikimedia.org/w/api.php?action=query&titles=$fe&prop=imageinfo&iiprop=url&format=json"
                $ir = Invoke-WebRequest -Uri $infoUrl -UseBasicParsing -UserAgent 'WhereToNextZim/1.0 (info@wheretonext.co.zw)'
                $ij = ConvertFrom-Json $ir.Content
                foreach ($p in $ij.query.pages.PSObject.Properties) {
                    if ($p.Value.imageinfo) {
                        return [PSCustomObject]@{
                            Query = $q
                            File = $title
                            Url = $p.Value.imageinfo[0].url
                        }
                    }
                }
            }
        }
    } catch {
        Write-Warning "Error for ${q}: $($_.Exception.Message)"
    }
    return $null
}

foreach ($q in $queries) {
    $res = Search-Commons -q $q
    if ($res) {
        Write-Output "$($res.Query) => $($res.Url)"
    } else {
        Write-Output "$q => NOT FOUND"
    }
}
