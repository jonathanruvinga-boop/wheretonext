param([string]$url)
try {
    $r = Invoke-WebRequest -Uri $url -UseBasicParsing -UserAgent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' -TimeoutSec 10
    $m = [regex]::Matches($r.Content, '(https?://[^\s"''<>]+\.(?:jpg|jpeg|png|webp))')
    $urls = @{}
    foreach ($match in $m) {
        $u = $match.Groups[1].Value
        if (-not $urls.ContainsKey($u) -and $u -notmatch 'logo' -and $u -notmatch 'icon' -and $u -notmatch 'avatar') {
            $urls[$u] = $true
            Write-Output $u
        }
    }
} catch {
    Write-Output "ERROR: $($_.Exception.Message)"
}
