Add-Type -AssemblyName System.Drawing

function Rotate-ImageFile([string]$path, [string]$rotation) {
    $src = [System.IO.Path]::GetFullPath($path)
    $img = [System.Drawing.Image]::FromFile($src)
    if ($rotation -eq "Rotate90") {
        $img.RotateFlip([System.Drawing.RotateFlipType]::Rotate90FlipNone)
    }
    $tmp = $src + ".tmp.jpg"
    $img.Save($tmp, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $img.Dispose()
    Remove-Item $src -Force
    Move-Item $tmp $src -Force
    Write-Host "Rotated and saved $path"
}

Rotate-ImageFile -path (Join-Path $PSScriptRoot "buses\cag-travellers.jpg") -rotation "Rotate90"
Rotate-ImageFile -path (Join-Path $PSScriptRoot "buses\city-bus.jpg") -rotation "Rotate90"
