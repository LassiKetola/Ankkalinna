local function uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
end


function createAuctionObject(data)
    return {
        [uuid()] = {
            item=data["item"],
                crawled_at=date("%Y-%m-%d %H:%M:%S", time()),
                count=data["count"],
                price={
                    gold = math.floor(data["price"] / 10000),
                    silver = math.floor((data["price"] % 10000) / 100),
                    copper = data["price"] % 100
                },
                seller=data["seller"],
                category=STATE["selected-category"]
            }
        }
end

-- name, minLevel, maxLevel, page, isUsable, rarity, getAll, filterData
function queryItem(payload)
    QueryAuctionItems(STATE["selected-item"], 0, 70, 0, nil, 0, nil, true, nil)
end

function getLastPageNum()
    local batchSize, lastPageNum = GetNumAuctionItems("list")
    print(batchSize, lastPageNum, math.floor(lastPageNum / batchSize))
end

function getPageData()
    for i = 1, 50 do
        local name, _, count, _, _, _, _, _, _, buyout, _, _, _, owner, _, _, itemId, hasAllInfo = GetAuctionItemInfo("list", i)
        local gold = math.floor(buyout / 10000)
        local silver = math.floor((buyout % 10000) / 100)
        local copper = buyout % 100
        if AuctionCrawler == nil then
            AuctionCrawler = {}
        end
        table.insert(AuctionCrawler, createAuctionObject({item=name, seller=owner, price=buyout, count=count}))
    end
end