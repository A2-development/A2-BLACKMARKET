QBCore = exports['qb-core']:GetCoreObject()


Citizen.CreateThread(function()
    local loc = Config.BotLocations[math.random(#Config.BotLocations)] 
    local ped = CreatePed(4, GetHashKey(Config.Ped), loc.x, loc.y, loc.z, loc.w, false, true)
    SetEntityInvincible(ped, true)
    SetEntityVisible(ped, true)
    FreezeEntityPosition(ped, true)
    TaskStartScenarioInPlace(ped, Config.Ani, 0, true)

        if Config.interact then
            exports.interact:AddInteraction({
                coords = vector3(loc.x, loc.y, loc.z + 1.0),
                distance = 4.0,    
                interactDst = 1.0, 
                id = math.random(100000, 999999), 
                options = {
                    {
                        event = 'a2shop:client:123',
                        label = 'Talk To Me',
                    },
                }
            })
        else
        exports['qb-target']:AddTargetEntity(ped, {
            options = {
                {
                    type = "client",
                    event = "a2shop:client:123",
                    icon = "fas fa-cogs",
                    label = "Talk To Me"
                },
            },
            distance = 3.0
            })
        end
end)


RegisterCommand('opencrime', function()
    TriggerEvent('a2shop:client:openMenu')
end)


RegisterNetEvent('a2shop:client:openMenu', function()
    local shopMenu = {
        {
            header = "Buy Crime Items",
            icon = "fa-solid fa-mask",
            isMenuHeader = true
        }
    }

    for _, v in pairs(Config.Items) do
        table.insert(shopMenu, {
            header = v.label .. " for $" .. v.price,
            txt = "<img src='nui://ox_inventory/web/images/" .. v.item .. ".png' style='width: 55px; height: 55px;'>",
            icon = "fa-solid fa-money-bill", 
            params = {
                event = "a2shop:client:buyItem",
                args = {item = v.item, price = v.price}
            }
        })
    end

    table.insert(shopMenu, {
        header = "I Will Back later",
        icon = "fa-solid fa-square-xmark",
        params = { event = "qb-menu:closeMenu" }
    })

    exports['qb-menu']:openMenu(shopMenu)
end)

RegisterNetEvent("a2shop:client:123", function()
    exports['qb-menu']:openMenu({
        {
            header = "Crime Items",
            icon = "fa-solid fa-mask",
            isMenuHeader = true
        },
        {
            header = "I want to buy itmes",
            txt = '',
            icon = 'fa-solid fa-money-bill',
            params = {
            event = 'a2shop:client:openMenu',
            }
        },
        {
            header = "I Will Back later",
            txt = '',
            icon = 'fa-solid fa-square-xmark',
            params = {
            event = 'qb-menu:closeMenu',
            }
        },
    })
end)

RegisterNetEvent('a2shop:client:buyItem', function(data)
    TriggerServerEvent('a2shop:server:buyItem', data.item, data.price)
end)


