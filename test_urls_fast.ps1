$urls = @(
    # Transport
    "https://citybuscoaches.com/assetsweb/images/ad/home/292921953_922146595846842_635688639958277256_n.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/0/04/C.A.G_Travellers_Coaches.jpg",
    "https://stallioncruise.com/wp-content/uploads/2025/12/full-bus.jpg",
    "https://bushlore.com/wp-content/uploads/2020/01/hilcam-day-2020.jpg",
    "https://www.crocomotors.co.zw/wp-content/uploads/2022/06/croco-ford-dealer-gall1.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/8/83/Tenda_Bus_%22baba_acho%22.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/f/f2/Mbare_Bus_Terminus1.jpg",

    # Places
    "https://upload.wikimedia.org/wikipedia/commons/5/5a/Victoria_Falls_Hotel.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/0/07/ZW_Bulawayo_Old_B_Club.JPG",
    "https://africansun.com/wp-content/uploads/2024/03/Property-General-Troutbeck-46-scaled.jpg",
    "https://www.leopardrockhotel.com/img/presidential-sunset.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Cataratas_Victoria%2C_Zambia-Zimbabue%2C_2018-07-27%2C_DD_04.jpg/1280px-Cataratas_Victoria%2C_Zambia-Zimbabue%2C_2018-07-27%2C_DD_04.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Conical_Tower_-_Great_Enclosure_III_%2833736918448%29.jpg/1280px-Conical_Tower_-_Great_Enclosure_III_%2833736918448%29.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Sunrise_Matobo_Zimbabwe.jpg/1280px-Sunrise_Matobo_Zimbabwe.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/4/45/ZmbziRvr.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/d/de/Mutarazi_Falls00.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/a/a1/Lake_Kariba.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Buffalo_bend.jpg/1280px-Buffalo_bend.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Chinhoyi_caves%2C_Zimbabwe.JPG/1280px-Chinhoyi_caves%2C_Zimbabwe.JPG",
    "https://upload.wikimedia.org/wikipedia/commons/9/96/Central_nyanga_np.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/Mount_Vumba_%286555288481%29.jpg/1280px-Mount_Vumba_%286555288481%29.jpg"
)

foreach ($u in $urls) {
    try {
        $req = [System.Net.WebRequest]::Create($u)
        $req.Timeout = 5000
        $req.UserAgent = "Mozilla/5.0"
        $resp = $req.GetResponse()
        Write-Output "OK 200: $u"
        $resp.Close()
    } catch {
        Write-Output "FAIL: $u -> $($_.Exception.Message)"
    }
}
