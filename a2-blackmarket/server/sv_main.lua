local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('a2shop:server:buyItem', function(item, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player then
        local cash = Player.Functions.GetMoney('cash')

        if cash >= price then
            Player.Functions.RemoveMoney('cash', price)
            Player.Functions.AddItem(item, 1)
            TriggerClientEvent('QBCore:Notify', src, "I have purchased " .. item .. "", "success")
        else
            TriggerClientEvent('QBCore:Notify', src, "you don't have enough money!", "error")
        end
    end
end)


