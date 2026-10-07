$urls = @(
    "https://commons.wikimedia.org/wiki/Special:FilePath/Hotel%20Chimanimani%2C%20Garden%20-%20panoramio.jpg",
    "https://commons.wikimedia.org/wiki/Special:FilePath/Hotel%20Chimanimani%2C%20Pool%20-%20panoramio.jpg"
)

foreach ($u in $urls) {
    try {
        $req = [System.Net.HttpWebRequest]::Create($u)
        $req.Timeout = 8000
        $req.UserAgent = "WhereToNextBot/1.0 (info@wtnz.com)"
        $resp = $req.GetResponse()
        Write-Output "OK 200: $u"
        $resp.Close()
    } catch {
        Write-Output "FAIL: $u -> $($_.Exception.Message)"
    }
}
