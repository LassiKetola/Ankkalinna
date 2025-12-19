local SelectableItems = CreateFrame("Frame", "SelectableItems", CrawlerFrame, "BackdropTemplate")
SelectableItems:SetSize(180, 390)
SelectableItems:SetPoint("TOPLEFT", 12, -30)
SelectableItems:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
SelectableItems:SetBackdropColor(0, 0, 0, 1)
SelectableItems:Show()
SelectableItems:SetFrameLevel(200)

local BackgroundFrame = CreateFrame("Frame", "BackgroundFrame", SelectableItems, "InsetFrameTemplate")
BackgroundFrame:SetSize(180, 150)
BackgroundFrame:SetAllPoints(SelectableItems)

local ScrollContainerFrame = CreateFrame("Frame", "ScrollContainerFrame", BackgroundFrame, "BackdropTemplate")
ScrollContainerFrame:SetPoint("TOPLEFT")
ScrollContainerFrame:SetAllPoints(BackgroundFrame)

local IconScrollFrame = CreateFrame("ScrollFrame", "IconScrollFrame", ScrollContainerFrame, "ListScrollFrameTemplate")
IconScrollFrame:SetPoint("TOPLEFT", 3, -4)
IconScrollFrame:SetPoint("BOTTOMRIGHT", -22, 0)

FauxScrollFrame_Update(IconScrollFrame, 120, 4, 6)

local function updateSelected(targetFrame)
    for i = 0, #Data do
        local currentFrame = _G["Item" .. i]
        if currentFrame then
            if currentFrame:GetName() == targetFrame:GetName() then
                currentFrame:SetActive()
            else
                currentFrame:ClearIcon()
            end
        end
    end
end

local IconScrollChildFrame = CreateFrame("Frame", "IconScrollChildFrame")
IconScrollFrame:SetScrollChild(IconScrollChildFrame)
IconScrollChildFrame:SetWidth(150)
IconScrollChildFrame:SetHeight(1000)

local function CreateIcon(frame, key, value, rowIndex, row)
    local borderframe = CreateFrame("Frame", "ItemFrame" .. key , frame, "BackdropTemplate")
    borderframe:SetSize(39, 39)
    borderframe:SetPoint("TOPLEFT", rowIndex * 39, row * -39)
    borderframe:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16
    })
    borderframe:SetBackdropBorderColor(100, 100, 0, 0)
    borderframe:SetBackdropColor(0, 0, 0, 1)
    
    local f = CreateFrame("Button", "Item" .. key, borderframe, "BackdropTemplate")
    f:SetSize(30, 30)
    f:SetPoint("TOPLEFT", 4, -4)
    f:SetPoint("BOTTOMRIGHT", -4, 4)
    f:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background"
    })
    f:SetBackdropColor(0.25, 0.25, 0.25, 1)

    f.texture = f:CreateTexture(nil, "OVERLAY")
    f.texture:SetAllPoints(f)
    f.texture:Show()
    f.texture:SetTexture(value["icon"])
    f.texture:SetDesaturated(true)

    function f:SetActive()
        f.texture:SetDesaturated(false)
        borderframe:SetBackdropBorderColor(100, 100, 0, 1)
    end

    function f:ClearIcon()
        f.texture:SetDesaturated(true)
        borderframe:SetBackdropBorderColor(0, 0, 0, 1)
    end

    f:SetScript("OnClick", function(self)
        STATE["selected-category"] = value["category"]
        STATE["selected-item"] = value["item"]
        updateSelected(self)
    end)

    f:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(value["item"], 1, 1, 1)
        GameTooltip:Show()
        f:SetAlpha(0.8)
    end)

    f:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        f:SetAlpha(1.0)
    end)
end

local function CreateItems(data)
    local currentItem = 0
    local currentRow = 0
    for key, value in pairs(data) do
        if currentItem > 3 then
            currentItem = 0
            currentRow = currentRow + 1
        end
        CreateIcon(IconScrollChildFrame, key, value, currentItem, currentRow)
        currentItem = currentItem + 1
    end
end

CreateItems(Data)
