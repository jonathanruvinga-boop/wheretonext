$content = [System.IO.File]::ReadAllText("$PSScriptRoot\wheretonext-zimbabwe.html")
$idx1 = $content.IndexOf("let PLACES_DATA = [")
if ($idx1 -ge 0) {
    $idx2 = $content.IndexOf("];", $idx1)
    $sub = $content.Substring($idx1, $idx2 - $idx1 + 2)
    $lines = $sub -split "`r?`n"
    $count = 0
    $name = ""
    $city = ""
    $category = ""
    foreach ($line in $lines) {
        if ($line.Contains('"name":')) {
            $name = $line.Split('"')[3]
        }
        if ($line.Contains('"category":')) {
            $category = $line.Split('"')[3]
        }
        if ($line.Contains('"city":')) {
            $city = $line.Split('"')[3]
        }
        if ($line.Contains('"img":')) {
            $img = $line.Split('"')[3]
            $count++
            [Console]::WriteLine("$count`t$name`t$city`t$category`t$img")
        }
    }
}
