$urls = @(
    "https://www.musangano.com/images/P1120288_cropped_1920.jpg",
    "https://theexplorer.co.zw/wp-content/uploads/2026/01/Forest-Hills-Resort-Deck-5-scaled.jpg",
    "https://foresthillsresort.co.zw/assets/website/images/slider/sunset-view.jpg",
    "https://byolife.co.zw/wp-content/uploads/2020/04/Eden-Lodge-Vumba-1.jpg",
    "https://lakealexander.co.zw/storage/images/6798769b73cd6.jpg",
    "https://pix10.agoda.net/hotelImages/19936210/0/93e6a22fa3fc8ada78e7156dc3336ff5.jpeg",
    "https://upload.wikimedia.org/wikipedia/commons/f/f7/Hotel_Chimanimani%2C_Garden_-_panoramio.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/5/56/Hotel_Chimanimani%2C_Pool_-_panoramio.jpg",
    "https://byolife.co.zw/wp-content/uploads/2021/02/boutique-hotel-in-Vumba_6-1-580x408.jpg",
    "https://commons.wikimedia.org/wiki/Special:FilePath/Chimanimani%20Mountains%20(4387137601).jpg"
)

foreach ($u in $urls) {
    try {
        $req = [System.Net.HttpWebRequest]::Create($u)
        $req.Timeout = 8000
        $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
        $resp = $req.GetResponse()
        Write-Output "OK 200: $u"
        $resp.Close()
    } catch {
        Write-Output "FAIL: $u -> $($_.Exception.Message)"
    }
}
