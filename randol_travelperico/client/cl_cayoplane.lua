local QBCore = exports['qb-core']:GetCoreObject()

function ResetSec()
    if DoesEntityExist(planeguide) then
        DeletePed(planeguide)
        DeletePed(returnplaneguide)
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        CayoPlaneGuy()
        ReturnCayoPlaneGuy()
    end
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    CayoPlaneGuy()
    ReturnCayoPlaneGuy()
end)

AddEventHandler('onResourceStop', function(resourceName) 
	if GetCurrentResourceName() == resourceName then
        ResetSec()
	end 
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    ResetSec()
end)

-- DEPARTURE

CreateThread(function()
    local planeblip = AddBlipForCoord(-1045.59, -2751.33, 20.36)
    SetBlipSprite(planeblip, 16)
    SetBlipColour(planeblip, 5)
    SetBlipScale(planeblip, 0.8)
    SetBlipAsShortRange(planeblip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Fly Perico")
    EndTextCommandSetBlipName(planeblip)
end)


function CayoPlaneGuy()
	if not DoesEntityExist(planeguide) then

        RequestModel("mp_m_securoguard_01")
        while not HasModelLoaded("mp_m_securoguard_01") do
            Wait(0)
        end

        planeguide = CreatePed(4, "mp_m_securoguard_01" , -1045.59, -2751.33, 20.36, 328.42, false, false)

        SetEntityAsMissionEntity(planeguide)
        SetBlockingOfNonTemporaryEvents(planeguide, true)
        SetEntityInvincible(planeguide, true)
        FreezeEntityPosition(planeguide, true)
        TaskStartScenarioInPlace(planeguide, "WORLD_HUMAN_STAND_MOBILE", 0, true)

        exports['qb-target']:AddTargetEntity(planeguide, {
            options = {
                {
                    type = "server",
                    event = "randol_cayoplane:server:takeplane",
                    icon = "fa-solid fa-plane-departure",
                    label = "Fly to Perico",
                },
            },
            distance = 2.5,
        })
	end
end


RegisterNetEvent('randol_cayoplane:client:takeplane')
AddEventHandler('randol_cayoplane:client:takeplane', function()
	local Ped = PlayerPedId()

	planemodel = GetHashKey("shamal")
	planeped = GetHashKey("s_m_y_pilot_01")
	
	RequestModel(planemodel)
	while not HasModelLoaded(planemodel) do
	Wait(0)
	end
	
	RequestModel(planeped)
	while not HasModelLoaded(planeped) do
	Wait(0)
	end
	
	if HasModelLoaded(planemodel) and HasModelLoaded(planeped) then
        TriggerServerEvent('randol_cayoplane:planecooldown')
		local ShamalPlane = CreateVehicle(planemodel, -1562.18, -2818.81, 13.0, true, false)
		exports['ps-fuel']:SetFuel(ShamalPlane, 100.0)
        SetEntityHeading(ShamalPlane, 240.76)
		SetEntityAsMissionEntity(ShamalPlane, true, true)
		SetModelAsNoLongerNeeded(ShamalPlane)
		TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
		local Pilot = CreatePedInsideVehicle(ShamalPlane, 6, planeped, -1, true, false)
		SetBlockingOfNonTemporaryEvents(Pilot, true)
		SetPedCanBeDraggedOut(Pilot, false)
		SetDriverAbility(Pilot, 1.0)
		SetDriverAggressiveness(Pilot, 0.0)
        DoScreenFadeOut(3000)
        Wait(4000)
        SetPedIntoVehicle(Ped, ShamalPlane, 1)
        Wait(2000)
        DoScreenFadeIn(3000)
		TaskVehicleDriveToCoord(Pilot, ShamalPlane, -907.64, -3196.72, 13.95, 30.0, 0, 1341619767, 786603, 1, true)
        Wait(13000)
        DoScreenFadeOut(3000)
        Wait(10000)
        SetEntityCoords(Ped, 4453.65, -4482.5, 3.22)
        FreezeEntityPosition(Ped, true)
        Wait(2000)
        FreezeEntityPosition(Ped, false)
        SetEntityCoords(ShamalPlane, 4452.29, -4506.29, 4.19)
        SetEntityHeading(ShamalPlane, 108.5)
        DoScreenFadeIn(2000)
        Wait(1500)
        TaskVehicleDriveToCoord(Pilot, ShamalPlane, 3475.4, -4868.43, 143.47, 20.0, 0, 1341619767, 786603, 1, true)
        Wait(10000)
		DeletePed(Pilot)
		QBCore.Functions.DeleteVehicle(ShamalPlane)
	end	
end)


-- RETURN PLANE

CreateThread(function()
    local returnplaneblip = AddBlipForCoord(4436.58, -4482.53, 3.32)
    SetBlipSprite(returnplaneblip, 16)
    SetBlipColour(returnplaneblip, 5)
    SetBlipScale(returnplaneblip, 0.8)
    SetBlipAsShortRange(returnplaneblip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Fly Perico")
    EndTextCommandSetBlipName(returnplaneblip)
end)

function ReturnCayoPlaneGuy()
	if not DoesEntityExist(returnplaneguide) then

        RequestModel("mp_m_securoguard_01")
        while not HasModelLoaded("mp_m_securoguard_01") do
            Wait(0)
        end

        returnplaneguide = CreatePed(4, "mp_m_securoguard_01" , 4436.58, -4482.53, 3.32, 210.16, false, false)

        SetEntityAsMissionEntity(returnplaneguide)
        SetBlockingOfNonTemporaryEvents(returnplaneguide, true)
        SetEntityInvincible(returnplaneguide, true)
        FreezeEntityPosition(returnplaneguide, true)
        TaskStartScenarioInPlace(returnplaneguide, "WORLD_HUMAN_STAND_MOBILE", 0, true)

        exports['qb-target']:AddTargetEntity(returnplaneguide, {
            options = {
                {
                    type = "server",
                    event = "randol_cayoplane:server:return",
                    icon = "fa-solid fa-plane-departure",
                    label = "Fly to LS",
                },
            },
            distance = 2.5,
        })
	end
end


RegisterNetEvent('randol_cayoplane:client:return')
AddEventHandler('randol_cayoplane:client:return', function()
	local Ped = PlayerPedId()

	returnplanemodel = GetHashKey("shamal")
	returnplaneped = GetHashKey("s_m_y_pilot_01")
	
	RequestModel(returnplanemodel)
	while not HasModelLoaded(returnplanemodel) do
	Wait(0)
	end
	
	RequestModel(returnplaneped)
	while not HasModelLoaded(returnplaneped) do
	Wait(0)
	end
	
	if HasModelLoaded(returnplanemodel) and HasModelLoaded(returnplaneped) then
        TriggerServerEvent('randol_cayoplane:planecooldown')
		local returnShamalPlane = CreateVehicle(returnplanemodel, 4452.09, -4506.35, 4.19, true, false)
		exports['ps-fuel']:SetFuel(returnShamalPlane, 100.0)
        SetEntityHeading(returnShamalPlane, 111.15)
		SetEntityAsMissionEntity(returnShamalPlane, true, true)
		SetModelAsNoLongerNeeded(returnShamalPlane)
		TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
		local returnPilot = CreatePedInsideVehicle(returnShamalPlane, 6, returnplaneped, -1, true, false)
		SetBlockingOfNonTemporaryEvents(returnPilot, true)
		SetPedCanBeDraggedOut(returnPilot, false)
		SetDriverAbility(returnPilot, 1.0)
		SetDriverAggressiveness(returnPilot, 0.0)
        DoScreenFadeOut(3000)
        Wait(4000)
        SetPedIntoVehicle(Ped, returnShamalPlane, 1)
        Wait(2000)
        DoScreenFadeIn(3000)
		TaskVehicleDriveToCoord(returnPilot, returnShamalPlane, 3475.4, -4868.43, 143.47, 20.0, 0, 1341619767, 786603, 1, true)
        Wait(10000)
        DoScreenFadeOut(3000)
        Wait(10000)
        SetEntityCoords(Ped, -1038.74, -2746.61, 20.36)
        Wait(2000)
		DeletePed(returnPilot)
		QBCore.Functions.DeleteVehicle(returnShamalPlane)
        DoScreenFadeIn(2000)
	end	
end)
