$html = Get-Content -Raw "c:\Users\USER\Desktop\wtnz\wheretonext-zimbabwe.html"

Write-Output "--- DESTINATIONS (Eastern Highlands) ---"
$regex = [regex]'\{\s*id:\s*"([^"]+)",\s*name:\s*"([^"]+)",\s*region:\s*"([^"]+)"[\s\S]*?img:\s*"([^"]+)"'
$matches = $regex.Matches($html)
foreach ($m in $matches) {
    if ($m.Groups[3].Value -match "Eastern") {
        Write-Output "$($m.Groups[1].Value) | $($m.Groups[2].Value) | $($m.Groups[4].Value)"
    }
}

Write-Output ""
Write-Output "--- PLACES_DATA (Eastern Highlands Hotels & Dinings) ---"
$start = $html.IndexOf("let PLACES_DATA = [")
$end = $html.IndexOf("];", $start)
$jsonStr = $html.Substring($start + 18, $end - ($start + 18)).Trim()
$places = ConvertFrom-Json ($jsonStr + "]")
foreach ($p in $places) {
    if ($p.city -match "Eastern") {
        Write-Output "$($p.id) | $($p.name) | $($p.category) | $($p.img)"
    }
}

Write-Output ""
Write-Output "--- HIDDEN GEMS (Eastern Highlands) ---"
$gemStart = $html.IndexOf("const HIDDEN_GEMS = [")
if ($gemStart -ge 0) {
    $gemEnd = $html.IndexOf("];", $gemStart)
    $gemText = $html.Substring($gemStart, $gemEnd - $gemStart + 2)
    Write-Output $gemText
}
