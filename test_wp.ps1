param([string]$title)
$enc = [System.Uri]::EscapeDataString($title)
$url = "https://en.wikipedia.org/w/api.php?action=query&titles=$enc&prop=pageimages&pithumbsize=1000&format=json"
try {
    $r = Invoke-WebRequest -Uri $url -UseBasicParsing -UserAgent 'WhereToNextBot/1.0 (info@wtnz.co.zw)'
    $j = ConvertFrom-Json $r.Content
    foreach ($p in $j.query.pages.PSObject.Properties) {
        if ($p.Value.thumbnail) {
            Write-Output "Title: $($p.Value.title)"
            Write-Output "Thumbnail: $($p.Value.thumbnail.source)"
        } else {
            Write-Output "No thumbnail for $($p.Value.title)"
        }
    }
} catch {
    Write-Output "ERR: $($_.Exception.Message)"
}
