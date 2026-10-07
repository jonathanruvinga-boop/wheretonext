$h = (Invoke-WebRequest -Uri 'https://lakealexander.co.zw/gallery' -UseBasicParsing -UserAgent 'Mozilla/5.0').Content
$matches = [regex]::Matches($h, 'src="([^"]+\.(?:jpg|jpeg|png))"')
foreach ($m in $matches) {
    Write-Host $m.Groups[1].Value
}
