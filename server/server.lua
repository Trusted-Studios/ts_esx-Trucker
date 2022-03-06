ESX = nil 

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

-- ════════════════════════════════════════════════════════════════════════════════════ --
--                                 ServerEvents - Blip                                  --
-- ════════════════════════════════════════════════════════════════════════════════════ --

RegisterServerEvent("GMW_Scripts:GiveTruckerMoney")
AddEventHandler("GMW_Scripts:GiveTruckerMoney", function(info, EndReward)
    local xPlayer = ESX.GetPlayerFromId(source)
    print(EndReward)
    xPlayer.addMoney(EndReward)
    TriggerClientEvent('esx:showNotification', source, "Du hast ~g~"..EndReward.."$~w~ von ~g~"..info.Reward.."$~w~ für deinen Auftrag bekommen")
end)    

RegisterServerEvent("GMW_Scripts:PayFee")
AddEventHandler("GMW_Scripts:PayFee", function(info)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeMoney(info.Reward)
    TriggerClientEvent('esx:showNotification', source, "~y~Ein Mitarbeiter~w~ hat die Ware abgeholt und sie zurück ins ~b~Depot~w~ gebracht!")
    TriggerClientEvent('esx:showNotification', source, "~r~Du musstest die Kosten für die Ware Übernehmen!~w~\r\nKosten: ~g~"..info.Reward.."$")
end)