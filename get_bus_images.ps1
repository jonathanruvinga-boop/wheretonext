$urls = @(
    "https://stallioncruise.com",
    "https://wildhorizons.co.za",
    "https://citylinkcoaches.co.zw"
)

foreach ($u in $urls) {
    try {
        $r = Invoke-WebRequest -Uri $u -UseBasicParsing -UserAgent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' -TimeoutSec 10
        Write-Host "=== $u ==="
        $matches = [regex]::Matches($r.Content, '<img[^>]+src=["'']([^"'']+)["'']')
        foreach ($m in $matches) {
            $src = $m.Groups[1].Value
            if ($src -match '\.(jpg|png|jpeg|webp)') {
                Write-Host $src
            }
        }
    } catch {
        Write-Host "Error fetching: " $_.Exception.Message
    }
}
