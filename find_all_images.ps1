$content = [System.IO.File]::ReadAllText("$PSScriptRoot\wheretonext-zimbabwe.html")
$lines = $content -split "`r?`n"
for ($i = 0; $i -lt $lines.Length; $i++) {
    $line = $lines[$i]
    if ($line -match 'img["'':]\s*["''](https?://[^"'']+|[^"'']+\.(jpg|png|jpeg|webp))' -or $line -match 'src=["''](https?://[^"'']+|[^"'']+\.(jpg|png|jpeg|webp))') {
        $found = $matches[1]
        [Console]::WriteLine(($i + 1).ToString() + ": " + $found)
    }
}
