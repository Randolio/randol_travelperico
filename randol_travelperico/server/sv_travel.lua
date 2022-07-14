local QBCore = exports['qb-core']:GetCoreObject()

local activeboat = false

function NextBoat()
    SetTimeout(60000, function() -- 1 minute cooldown. 
        activeboat = false
    end)
end


RegisterServerEvent('randol_cayoboat:boatcooldown', function()
    activeboat = true
    NextBoat()
end)

RegisterServerEvent("randol_cayoboat:server:takeboat")
AddEventHandler("randol_cayoboat:server:takeboat", function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)

    if not activeboat then
        TriggerClientEvent('randol_cayoboat:client:takeboat', source)
    else
        TriggerClientEvent('QBCore:Notify', source, "Boat already travelling. Next Boat: 1 Minute.", 'error')
    end
end)

RegisterServerEvent("randol_cayoboat:server:return")
AddEventHandler("randol_cayoboat:server:return", function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)

    if not activeboat then
        TriggerClientEvent('randol_cayoboat:client:return', source)
    else
        TriggerClientEvent('QBCore:Notify', source, "Boat already travelling. Next Boat: 1 Minute.", 'error')
    end
end)

-- PLANE

local activeflight = false

function NextPlane()
    SetTimeout(120000, function() -- 2 minute cooldown. 
        activeflight = false
    end)
end


RegisterServerEvent('randol_cayoplane:planecooldown', function()
    activeflight = true
    NextPlane()
end)

RegisterServerEvent("randol_cayoplane:server:takeplane")
AddEventHandler("randol_cayoplane:server:takeplane", function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)

    if not activeflight then
        TriggerClientEvent('randol_cayoplane:client:takeplane', source)
    else
        TriggerClientEvent('QBCore:Notify', source, "Flight in progress. Next Plane: 2 Minutes.", 'error')
    end
end)

RegisterServerEvent("randol_cayoplane:server:return")
AddEventHandler("randol_cayoplane:server:return", function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)

    if not activeflight then
        TriggerClientEvent('randol_cayoplane:client:return', source)
    else
        TriggerClientEvent('QBCore:Notify', source, "Flight in progress. Next Plane: 2 Minutes.", 'error')
    end
end)