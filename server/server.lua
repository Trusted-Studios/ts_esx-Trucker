---@diagnostic disable: trailing-space
-- ════════════════════════════════════════════════════════════════════════════════════ --
-- ESX Shared
-- ════════════════════════════════════════════════════════════════════════════════════ --

ESX = exports["es_extended"]:getSharedObject()

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Debug Logs
-- ════════════════════════════════════════════════════════════════════════════════════ --

local filename = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("^.*/(.*).lua$") or str
end
print("^6[SERVER - DEBUG] ^0: "..filename()..".lua gestartet");

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Code
-- ════════════════════════════════════════════════════════════════════════════════════ --

RegisterServerEvent("GMW_Scripts:GiveTruckerMoney", function(info, EndReward)
    local xPlayer = ESX.GetPlayerFromId(source)
    print(EndReward)
    xPlayer.addMoney(EndReward)
    TriggerClientEvent('esx:showNotification', source, "Du hast ~g~"..EndReward.."$~s~ von ~g~"..info.Reward.."$~s~ für deinen Auftrag bekommen")
end)    

RegisterServerEvent("GMW_Scripts:PayFee", function(info)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeMoney(info.Reward)
    TriggerClientEvent('esx:showNotification', source, "~y~Ein Mitarbeiter~w~ hat die Ware abgeholt und sie zurück ins ~b~Depot~s~ gebracht!")
    TriggerClientEvent('esx:showNotification', source, "~r~Du musstest die Kosten für die Ware Übernehmen!~s~\r\nKosten: ~g~"..info.Reward.."$")
end)