local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterServerEvent("sw-bank:server:giveItem",function()
    local chance = math.random(100)
    if chance <= 1 then TriggerClientEvent('rNotify:NotifyLeft', source, "nothing", "found", "generic_textures", "tick", 4000) return end
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local randomItem = Config.Rewards[math.random(1, #Config.Rewards)]
    local amount = math.random(1, 4)
    Player.Functions.AddItem(randomItem, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[randomItem], "add")
end)

RSGCore.Functions.CreateUseableItem("moneybag", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local moneybagreward = math.random(50,100)
    Player.Functions.AddMoney('cash', moneybagreward, 'used-moneybag')
    Player.Functions.RemoveItem('moneybag', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['moneybag'], "remove")
    TriggerClientEvent('RSGCore:Notify', src, '$'..moneybagreward..' from the moneybag', 'success')
end)