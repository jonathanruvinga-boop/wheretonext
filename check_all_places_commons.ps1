$places = @(
    "Troutbeck Resort",
    "Leopard Rock Hotel",
    "Aberfoyle Lodge",
    "Skydeck Mountain Retreat",
    "Rupurara Valley Lodge",
    "White Horse Inn Vumba",
    "Pine Tree Inn Nyanga",
    "Rhodes Nyanga Hotel",
    "Tony's Coffee Bvumba",
    "Inn on the Vumba",
    "Holiday Inn Mutare",
    "Golden Peacock Villa Mutare",
    "Montclair Hotel Nyanga",
    "Frog & Fern Cottages Chimanimani",
    "The Treehouse Chimanimani",
    "La Rochelle Country House",
    "Musangano Lodge",
    "Forest Hills Resort Vumba",
    "Eden Lodge Vumba",
    "Lake Alexander Resort",
    "Wise Owl Motel Mutare",
    "Chimanimani Hotel",
    "The Carvery Mutare",
    "The Victoria Falls Hotel",
    "The Boma Victoria Falls",
    "Shearwater Cafe Victoria Falls",
    "Bayete Guest Lodge",
    "Meikles Hotel",
    "Amanzi Restaurant Harare",
    "Armadale Lodge Harare",
    "Coimbra Restaurant Harare",
    "Camp Amalinda",
    "The Bulawayo Club",
    "The Cattleman Steakhouse Bulawayo",
    "The Musketeers Lodge Bulawayo",
    "Caribbea Bay Resort",
    "Bumi Hills Safari Lodge",
    "Hwange Safari Lodge",
    "Lodge at the Ancient City",
    "Ruckomechi Camp"
)

foreach ($p in $places) {
    $encoded = [System.Uri]::EscapeDataString($p)
    $url = "https://commons.wikimedia.org/w/api.php?action=query&list=search&srsearch=$encoded&srnamespace=6&srlimit=2&format=json"
    try {
        $r = Invoke-WebRequest -Uri $url -UseBasicParsing -UserAgent 'WhereToNextBot/1.0'
        $json = ConvertFrom-Json $r.Content
        $hits = $json.query.searchinfo.totalhits
        if ($hits -gt 0) {
            $title = $json.query.search[0].title
            $fileEnc = [System.Uri]::EscapeDataString($title)
            $u = "https://commons.wikimedia.org/w/api.php?action=query&titles=$fileEnc&prop=imageinfo&iiprop=url&format=json"
            $r2 = Invoke-WebRequest -Uri $u -UseBasicParsing -UserAgent 'WhereToNextBot/1.0'
            $j2 = ConvertFrom-Json $r2.Content
            $imgUrl = ""
            foreach ($prop in $j2.query.pages.PSObject.Properties) {
                if ($prop.Value.imageinfo) { $imgUrl = $prop.Value.imageinfo[0].url }
            }
            [Console]::WriteLine("FOUND`t$p`t$title`t$imgUrl")
        } else {
            [Console]::WriteLine("MISS`t$p")
        }
    } catch {
        [Console]::WriteLine("ERR`t$p`t" + $_.Exception.Message)
    }
}
