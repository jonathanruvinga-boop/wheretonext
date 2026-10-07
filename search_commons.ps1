param([string]$query)
$encoded = [System.Uri]::EscapeDataString($query)
$url = "https://commons.wikimedia.org/w/api.php?action=query&list=search&srsearch=$encoded&srnamespace=6&srlimit=5&format=json"
try {
    $r = Invoke-WebRequest -Uri $url -UseBasicParsing -UserAgent 'WhereToNextBot/1.0 (travel@wtnz.com)'
    $json = ConvertFrom-Json $r.Content
    Write-Host "Total hits:" $json.query.searchinfo.totalhits
    foreach ($item in $json.query.search) {
        $title = $item.title
        $fileEncoded = [System.Uri]::EscapeDataString($title)
        $infoUrl = "https://commons.wikimedia.org/w/api.php?action=query&titles=$fileEncoded&prop=imageinfo&iiprop=url&format=json"
        $infoResp = Invoke-WebRequest -Uri $infoUrl -UseBasicParsing -UserAgent 'WhereToNextBot/1.0 (travel@wtnz.com)'
        $infoJson = ConvertFrom-Json $infoResp.Content
        foreach ($prop in $infoJson.query.pages.PSObject.Properties) {
            if ($prop.Value.imageinfo) {
                Write-Host $title
                Write-Host $prop.Value.imageinfo[0].url
            }
        }
    }
} catch {
    Write-Host "Error: " $_.Exception.Message
}
