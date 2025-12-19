local INITIALIZED = false

local CrawlerFrame = CreateFrame("Frame", "CrawlerFrame", UIParent, "UIPanelDialogTemplate")
CrawlerFrame:SetPoint("CENTER")
CrawlerFrame:Hide()

CrawlerFrame:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")
CrawlerFrame:RegisterEvent("ADDON_LOADED")
CrawlerFrame:RegisterEvent("AUCTION_HOUSE_SHOW")

local CrawlerCloseButton = CrawlerFrameClose
CrawlerCloseButton:ClearAllPoints()
CrawlerCloseButton:SetPoint("TOPRIGHT", CrawlerFrame, "TOPRIGHT", 2, 0)

CrawlerFrame:SetScript("OnEvent", function(self, eventName)
    if eventName == "AUCTION_HOUSE_SHOW" then
        CrawlerFrame:SetParent(AuctionFrame)
        CrawlerFrame:SetPoint("TOPLEFT", AuctionFrame, "TOPRIGHT", 0, -10)
        CrawlerFrame:SetWidth(200)
        CrawlerFrame:SetHeight(AuctionFrame:GetHeight()-15)
        CrawlerFrame:Show()
    end
    if eventName == "AUCTION_ITEM_LIST_UPDATE" then
        getLastPageNum()
        getPageData()
    end

    if eventName == "ADDON_LOADED" and INITIALIZED == false then
        INITIALIZED = true
        AuctionCrawler = {}
    end
end)

CrawlerFrame:SetClipsChildren(true)