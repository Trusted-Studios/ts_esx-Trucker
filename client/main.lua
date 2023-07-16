---@diagnostic disable: param-type-mismatch, undefined-global, missing-parameter
-- ════════════════════════════════════════════════════════════════════════════════════ --
-- ESX Shared 
-- ════════════════════════════════════════════════════════════════════════════════════ --

ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Debug Logs
-- ════════════════════════════════════════════════════════════════════════════════════ --

local filename = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("^.*/(.*).lua$") or str
end
print("^6[CLIENT - DEBUG] ^0: "..filename()..".lua gestartet");

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Code
-- ════════════════════════════════════════════════════════════════════════════════════ --

local Info = {
    NPC = "s_m_y_ammucity_01",
}

local currentVehicle = nil
local CurrentBlip = nil
local IsTrailerAttached = false
DriveToDepot = false

function Info:SpawnPed()
    local hash = GetHashKey(self.NPC)
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Citizen.Wait(20)
	end
    for k, v in pairs(Config.DepotPoint) do
        local x, y, z, h = table.unpack(v.Coords)
        local npc = CreatePed("PED_TYPE_CIVMALE", self.NPC, x + 1, y, z - 1, h, false, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        TaskStartScenarioInPlace(npc, "WORLD_HUMAN_AA_SMOKE", 0, 1)
    end
end

function Info:AddBlip()
    for k, v in pairs(Config.DepotPoint) do
        local x, y, z = table.unpack(v.Coords)
        local blip = AddBlipForCoord(x, y, z)
        SetBlipSprite(blip, 67)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, -1)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.Label)
        EndTextCommandSetBlipName(blip)
    end
end

function Info:SpawnVehicle(x, y, z, h) 
    local ped <const> = GetPlayerPed(-1)
    SetEntityCoords(ped, x, y, z)
    SetEntityHeading(ped, h)
    local i = math.random(1, #Config.Trucks)
    spawnCar(Config.Trucks[i].spwn)
    Console_Log(Config.Trucks[i].spwn)
    currentVehicle = Config.Trucks[i].spwn
end

function Info:SpawnTrailer(x, y, z, h)
    local i = math.random(1, #Config.Trailers)
    SpawnTrailer(Config.Trailers[i].spwn, x, y, z, h)
    Console_Log(Config.Trailers[i].spwn)
end

function Info:IsTrailerAttached()
    Citizen.Wait(0)
    local ped <const> = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped)
    while not IsVehicleAttachedToTrailer(veh) do
        Citizen.Wait(0)
        return false
    end
    return true
end

function Info:Reward(reward)
    local ped <const> = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped)
    while true do
        Citizen.Wait(0)
        local vehHealth
        if Config.Health == "body" then
            vehHealth = GetVehicleBodyHealth(veh)
        elseif Config.Health == "engine" then
            vehHealth = GetVehicleEngineHealth(veh)
        end
        local int = vehHealth * reward / 1000
        local EndReward = round(int)
        return EndReward
    end
end

function Info:GetDistance(x, y, z, distance)
    local ped <const> = GetPlayerPed(-1)
    local coords = GetEntityCoords(ped)
    local dist = Vdist(coords, x, y, z)
    if dist <= distance then
        return true
    else
        return false
    end
end

function Info:ShowProgressbar(time)
    local int = 0
    while int <= 120 do
        Citizen.Wait(0)
        Visual.Subtitle("Warte bis die Ware abgeladen wurde.", 0)
        DisablePlayerControls()
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(9)
        RenderRect(850, 1034.5, 190, 30, 0, 0, 0, 120)
        drawProgressBar(0.9305, 0.972, 0.0690, 0.0085, {0, 128, 255, 150}, 120)
        drawProgressBar(0.9305, 0.972, 0.0690, 0.0085, {0, 128, 255, 255}, int)
        Citizen.CreateThread(function()
            Citizen.Wait(time)
            int = int + (1.2 / time)
        end)
    end
end

function Info:DisplayBlip(newBlip, msg, sprite, colour, route)
    CurrentBlip = newBlip
    SetBlipSprite(newBlip, sprite)
    SetBlipDisplay(newBlip, 6)
    SetBlipScale(newBlip, 1.0)
    SetBlipColour(newBlip, colour)
    if route then
        SetBlipRoute(newBlip, true)
        SetBlipRouteColour(newBlip, colour)
    end
    SetBlipAsShortRange(newBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(msg)
    EndTextCommandSetBlipName(newBlip)
end

function Info:DriveToCoords(x, y, z, event, newBlip, info)
    while JobStarted do
        Citizen.Wait(0)
        while DriveToCoords or DriveToDepot == true do
            Citizen.Wait(0)
            if IsTrailerAttached then
                if Info:GetDistance(x, y, z, 20) then
                    addMarker(x, y, z)
                    if Info:GetDistance(x, y, z, 8) then
                        RemoveBlip(newBlip)
                        newBlip = nil
                        TriggerEvent("GMW_Scripts:"..event, info)
                        IsTrailerAttached = true; DriveToCoords = false; DriveToDepot = false;
                    end
                end
            end
        end
        break
    end
end

function Info:FinishJob(info, reward, x, y, z)
    local ped <const> = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped)
    if GetEntityModel(veh) == GetHashKey(currentVehicle) then
        DoScreenFadeOut(1000)
        Citizen.Wait(1200)
        if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
            local pos = GetEntityCoords(ped)
            if (GetPedInVehicleSeat(veh, -1) == ped) then
                SetEntityAsMissionEntity(veh, true, true)
                TriggerServerEvent("GMW_Scripts:GiveTruckerMoney", info, reward)
                deleteCar(veh)
                SetEntityCoords(ped, x, y, z)
                JobStarted = false
            end
        end
        Citizen.Wait(1200)
        DoScreenFadeIn(1000)
        Citizen.Wait(800)
    else
        DoScreenFadeOut(1000)
        Citizen.Wait(1200)
        if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
            if (GetPedInVehicleSeat(veh, -1) == ped) then
                SetEntityAsMissionEntity(veh, true, true)
                deleteCar(veh)
                SetEntityCoords(ped, x, y, z)
                JobStarted = false
            end
        end
        DoScreenFadeIn(1000)
        Citizen.Wait(1200)
        notify("Du hast den Auftrag erfolglos abgeschlossen..")
        notify("~r~Demnächst solltest du auch mit dem Truck zurück kommen mit dem du losgefahren bist!")
        JobStarted = false
    end
end

Citizen.CreateThread(function()
    Info:SpawnPed()
    Info:AddBlip()
end)

AddEventHandler("GMW_Scripts:TJ_StartJob", function(info)
    DoScreenFadeOut(1000)
    Citizen.Wait(3000)
    Citizen.CreateThread(function()
        local x, y, z, h = table.unpack(Config.VehSpawnPoint)
        Info:SpawnVehicle(x, y, z, h)
    end)
    Citizen.CreateThread(function()
        local x, y, z, h = table.unpack(Config.TrailerSpwnPoint)
        Info:SpawnTrailer(x, y, z, h)
    end)
    TriggerEvent("GMW_Scripts:IsTrailerAttached", info)
    Citizen.Wait(2000)
    DoScreenFadeIn(1000)
    TriggerEvent("GMW_Scripts:ShowHUDComponents", info)
    TriggerEvent("GMW_Scripts:DrawRoute", info)
    Citizen.Wait(800)
end)

AddEventHandler("GMW_Scripts:IsTrailerAttached", function(info)
    while JobStarted do
        Citizen.Wait(500)
        if Info:IsTrailerAttached() then
            IsTrailerAttached = true
        else
            IsTrailerAttached = false
            Citizen.CreateThread(function()
                while JobStarted do
                    Citizen.Wait(0)
                    if IsTrailerAttached == false then
                        Visual.Subtitle("~y~Hole den Trailer ab.", 0)
                    end
                end
            end)
        end
    end
end)


AddEventHandler("GMW_Scripts:ShowHUDComponents", function(info)
    while JobStarted do
        Citizen.Wait(0)
        if IsTrailerAttached then
            Citizen.CreateThread(function()
                while DriveToCoords do
                    Citizen.Wait(0)
                    if IsTrailerAttached then
                        Visual.Subtitle("Lohn: ~g~"..Info:Reward(info.Reward).."$ ~w~| Fahre zum Zielort: ~b~"..info.Label..".", 1000)
                    end
                end
            end)
            Citizen.CreateThread(function()
                while DriveToDepot do
                    Citizen.Wait(0)
                    Visual.Subtitle("Lohn: ~g~"..Info:Reward(info.Reward).."$ ~w~| Fahre zurück zum Depot.", 1000)
                end
            end)
        end
        Citizen.Wait(500)
    end
end)

AddEventHandler("GMW_Scripts:DrawRoute", function(info)
    while not IsTrailerAttached do
        Citizen.Wait(500)
    end
    local x, y, z = table.unpack(info.Coords)
    local newBlip = AddBlipForCoord(x, y, z)
    Info:DisplayBlip(newBlip, "Zielort", 1, 5, true)
    Info:DriveToCoords(x, y, z, "Deliver", newBlip, info)
end)

AddEventHandler("GMW_Scripts:Deliver", function(info)
    TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1)), 1, 1000)
    Info:ShowProgressbar(10)
    ShowHelp("~g~Ware wurde abgeliefert!", true, 4000)
    PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    PlaySoundFrontend(-1, "MEDAL_GOLD", "HUD_AWARDS", 0)
    TriggerEvent("GMW_Scripts:DriveBack", info)
end)

AddEventHandler("GMW_Scripts:DriveBack", function(info)
    local x, y, z = table.unpack(Config.EndPoint)
    local newBlip = AddBlipForCoord(x, y, z)
    Info:DisplayBlip(newBlip, "Zielort", 1, 5, true)
    DriveToDepot = true
    Info:DriveToCoords(x, y, z, "EndJob", newBlip, info)
end)

AddEventHandler("GMW_Scripts:EndJob", function(info)
    local x, y, z = table.unpack(Config.EndPoint)
    Console_Log(Info:Reward(info.Reward))
    local EndReward = Info:Reward(info.Reward)
    Info:FinishJob(info, EndReward, x, y, z)
end)

AddEventHandler("GMW_Scripts:AbortJob", function(info)
    JobStarted = false; DriveToCoords = false; DriveToDepot = false
    Console_Log("CurrentBlip: "..CurrentBlip)
    RemoveBlip(CurrentBlip)
    CurrentBlip = nil
    TriggerServerEvent("GMW_Scripts:PayFee", info)
end)