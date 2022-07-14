local QBCore = exports['qb-core']:GetCoreObject()

function DeleteGuide()
    if DoesEntityExist(cayoguide) then
        DeletePed(cayoguide)
        DeletePed(returngeeza)
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        CayoBoatGuy()
        CayoReturnGuy()
    end
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    CayoBoatGuy()
    CayoReturnGuy()
end)

AddEventHandler('onResourceStop', function(resourceName) 
	if GetCurrentResourceName() == resourceName then
        DeleteGuide()
	end 
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    DeleteGuide()
end)


-- DEPARTURE BOAT

CreateThread(function()
    local blip = AddBlipForCoord(-293.63, -2769.99, 1.2)
    SetBlipSprite(blip, 404)
    SetBlipColour(blip, 2)
    SetBlipScale(blip, 0.8)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Travel Perico")
    EndTextCommandSetBlipName(blip)
end)


function CayoBoatGuy()
	if not DoesEntityExist(cayoguide) then

        RequestModel("csb_miguelmadrazo")
        while not HasModelLoaded("csb_miguelmadrazo") do
            Wait(0)
        end

        cayoguide = CreatePed(4, "csb_miguelmadrazo" , -293.63, -2769.99, 1.2, 0.31, false, false)

        SetEntityAsMissionEntity(cayoguide)
        SetBlockingOfNonTemporaryEvents(cayoguide, true)
        SetEntityInvincible(cayoguide, true)
        FreezeEntityPosition(cayoguide, true)
        TaskStartScenarioInPlace(cayoguide, "WORLD_HUMAN_STAND_MOBILE", 0, true)

        exports['qb-target']:AddTargetEntity(cayoguide, {
            options = {
                {
                    type = "server",
                    event = "randol_cayoboat:server:takeboat",
                    icon = "fa-solid fa-ship",
                    label = "Travel to Perico",
                },
            },
            distance = 2.5,
        })
	end
end


RegisterNetEvent('randol_cayoboat:client:takeboat')
AddEventHandler('randol_cayoboat:client:takeboat', function()
	local Ped = PlayerPedId()

	boatmodel = GetHashKey("toro")
	boatped = GetHashKey("ig_gustavo")
	
	RequestModel(boatmodel)
	while not HasModelLoaded(boatmodel) do
	Wait(0)
	end
	
	RequestModel(boatped)
	while not HasModelLoaded(boatped) do
	Wait(0)
	end
	
	if HasModelLoaded(boatmodel) and HasModelLoaded(boatped) then
        TriggerServerEvent('randol_cayoboat:boatcooldown')
		local ToroBoat = CreateVehicle(boatmodel, -292.67, -2765.97, 0.0, true, false)
		exports['ps-fuel']:SetFuel(ToroBoat, 100.0)
        	SetEntityHeading(ToroBoat, 269.76)
		SetEntityAsMissionEntity(ToroBoat, true, true)
		SetModelAsNoLongerNeeded(ToroBoat)
		TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
		local Driver = CreatePedInsideVehicle(ToroBoat, 6, boatped, -1, true, false)
		SetPedIntoVehicle(Ped, ToroBoat, 1)
		SetBlockingOfNonTemporaryEvents(Driver, true)
		SetPedCanBeDraggedOut(Driver, false)
		SetDriverAbility(Driver, 1.0)
		SetDriverAggressiveness(Driver, 0.0)
        	Wait(2000)
		TaskVehicleDriveToCoord(Driver, ToroBoat, -238.52, -3035.54, 0.46, 30.0, 0, 1341619767, 786603, 1, true)
        	Wait(1000)
        	DoScreenFadeOut(3000)
        	Wait(10000)
        	SetEntityCoords(Ped, 4930.65, -5146.29, 1.48)
        	FreezeEntityPosition(Ped, true)
		Wait(2000)
		FreezeEntityPosition(Ped, false)
		SetEntityCoords(ToroBoat, 4930.91, -5150.39, 0.05) 
		SetEntityHeading(ToroBoat, 71.06)
		DoScreenFadeIn(2000)
		TaskVehicleDriveToCoord(Driver, ToroBoat, 4776.16, -5158.03, 1.57, 20.0, 0, 1341619767, 786603, 1, true)
		Wait(9000)
		DeletePed(Driver)
		QBCore.Functions.DeleteVehicle(ToroBoat)
	end	
end)


--- RETURN BOAT

CreateThread(function()
    local returnblip = AddBlipForCoord(4930.81, -5175.23, 2.46)
    SetBlipSprite(returnblip, 404)
    SetBlipColour(returnblip, 2)
    SetBlipScale(returnblip, 0.8)
    SetBlipAsShortRange(returnblip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Travel LS")
    EndTextCommandSetBlipName(returnblip)
end)

function CayoReturnGuy()
	if not DoesEntityExist(returngeeza) then

        RequestModel("csb_miguelmadrazo")
        while not HasModelLoaded("csb_miguelmadrazo") do
            Wait(0)
        end

        returngeeza = CreatePed(4, "csb_miguelmadrazo" , 4929.34, -5174.51, 1.48, 265.74, false, false)

        SetEntityAsMissionEntity(returngeeza)
        SetBlockingOfNonTemporaryEvents(returngeeza, true)
        SetEntityInvincible(returngeeza, true)
        FreezeEntityPosition(returngeeza, true)
        TaskStartScenarioInPlace(returngeeza, "WORLD_HUMAN_STAND_MOBILE", 0, true)

        exports['qb-target']:AddTargetEntity(returngeeza, {
            options = {
                {
                    type = "server",
                    event = "randol_cayoboat:server:return",
                    icon = "fa-solid fa-ship",
                    label = "Travel to LS",
                },
            },
            distance = 2.5,
        })
	end
end

RegisterNetEvent('randol_cayoboat:client:return')
AddEventHandler('randol_cayoboat:client:return', function()
	local Ped = PlayerPedId()

	returnboatmodel = GetHashKey("toro")
	returnboatped = GetHashKey("ig_gustavo")
	
	RequestModel(returnboatmodel)
	while not HasModelLoaded(returnboatmodel) do
	Wait(0)
	end
	
	RequestModel(returnboatped)
	while not HasModelLoaded(returnboatped) do
	Wait(0)
	end
	
	if HasModelLoaded(returnboatmodel) and HasModelLoaded(returnboatped) then
        TriggerServerEvent('randol_cayoboat:boatcooldown')
		local returnToroBoat = CreateVehicle(returnboatmodel, 4933.01, -5171.59, -0.56, true, false)
		exports['ps-fuel']:SetFuel(returnToroBoat, 100.0)
        	SetEntityHeading(returnToroBoat, 61.45)
		SetEntityAsMissionEntity(returnToroBoat, true, true)
		SetModelAsNoLongerNeeded(returnToroBoat)
		TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
		local returnDriver = CreatePedInsideVehicle(returnToroBoat, 6, returnboatped, -1, true, false)
		SetPedIntoVehicle(Ped, returnToroBoat, 1)
		SetBlockingOfNonTemporaryEvents(returnDriver, true)
		SetPedCanBeDraggedOut(returnDriver, false)
		SetDriverAbility(returnDriver, 1.0)
		SetDriverAggressiveness(returnDriver, 0.0)
		TriggerServerEvent('randol_cayoboat:boatcooldown')
		Wait(2000)
		TaskVehicleDriveToCoord(returnDriver, returnToroBoat, 4776.16, -5158.03, 1.57, 20.0, 0, 1341619767, 786603, 1, true)
		Wait(1000)
		DoScreenFadeOut(3000)
		Wait(10000)
		SetEntityCoords(Ped, -295.77, -2769.06, 2.2)
		DeletePed(returnDriver)
		QBCore.Functions.DeleteVehicle(returnToroBoat)
		Wait(1500)
		DoScreenFadeIn(2000)
	end	
end)
