local function CrawlerButtons()
    local CrawlButtons = CreateFrame("Frame", "CrawlButtons", CrawlerFrame, "BackdropTemplate")
    CrawlButtons:SetSize(120, 20)
    CrawlButtons:SetPoint("TOP", 0, -6)
    CrawlButtons:SetFrameLevel(200)

    local CrawlButton = CreateFrame("Button", "CrawlButton", CrawlButtons, "UIPanelButtonTemplate")
    CrawlButton:SetSize(60, 20)
    CrawlButton:SetPoint("BOTTOM", -30, 0)
    CrawlButton:SetText("Crawl")
    CrawlButton:SetScript("OnClick", function(self)
        queryItem()
    end)

    local FullScan = CreateFrame("Button", "FullScan", CrawlButtons, "UIPanelButtonTemplate")
    FullScan:SetSize(60, 20)
    FullScan:SetPoint("BOTTOM", 30, 0)
    FullScan:SetText("Scan All")
end

CrawlerButtons()