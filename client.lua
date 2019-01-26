--------------------------------
--- Fax Admin, Made by FAXES ---
--------------------------------
-- Copyright © 2019 FAXES // Fraffel Media

adminInvisSet = false

function ShowInfo(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

RegisterNetEvent('FaxAdmin:ShowInfo')
AddEventHandler('FaxAdmin:ShowInfo', function(notetext)
	ShowInfo(notetext)
end)

function ManageFrozenPlayer()
	if isFrozen then
		local ped = GetPlayerPed(-1)
		if DoesEntityExist(ped) and not IsEntityDead(ped) then
			local player = PlayerId()
			if not IsEntityVisible(ped) then
				SetEntityVisible(ped, true)
			end
			ClearPedTasksImmediately(ped)
			RemoveAllPedWeapons(ped, false)
			SetEntityCollision(ped, false)
			FreezeEntityPosition(ped, true)
			SetPlayerInvincible(player, true)
			SetEntityCoords(ped, pos_frozen.x, pos_frozen.y, pos_frozen.z - 1.2)
		end
	end
end

RegisterNetEvent('Fax:SendFrontedSound')
AddEventHandler('Fax:SendFrontedSound', function(SoundName, SoundSetName)
	PlaySoundFrontend(-1, SoundName, SoundSetName, 1)
end)

RegisterNetEvent('FaxA:SetAdminInvis')
AddEventHandler('FaxA:SetAdminInvis', function()
	adminInvisSet = not adminInvisSet
	if adminInvisSet then
		ShowInfo("~b~Your admin status is now: ~g~Invisible")
		print("[Just Another Admin Script - By FAXES] Your admin status is now: Invisible")
	else
		ShowInfo("~b~Your admin status is now: ~g~Visible")
		print("[Just Another Admin Script - By FAXES] Your admin status is now: Visible")
	end
end)

------------------------------------------------------------
RegisterNetEvent("FaxA:SlapPlayer")
AddEventHandler('FaxA:SlapPlayer', function()
	local ped_l = GetPlayerPed(PlayerId())
	if DoesEntityExist(ped_l) and not IsEntityDead(ped_l) then
		local forcecount = 0
		if IsPedInAnyVehicle(ped_l, true) then
			local veh = GetVehiclePedIsUsing(ped_l)
			repeat
				ApplyForceToEntity(veh, 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
				forcecount = forcecount + 1
				Citizen.Wait(0)
			until(forcecount > 10)
		else
			ApplyForceToEntity(ped_l, 1, 3000.0, 3.0, 3000.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
			Citizen.Wait(100)
			SetPedToRagdoll(ped_l, 500, 500, 0, false, false, false)
		end
		forcecount = 0
	end
end)

--------------------------------------------------------------------
RegisterNetEvent("FaxA:CrashPlayer")
AddEventHandler('FaxA:CrashPlayer', function()
	while true do
	end
end)

RegisterNetEvent("FaxA:KillPlayer")
AddEventHandler('FaxA:KillPlayer', function()
	local ped_l = GetPlayerPed(-1)
	if DoesEntityExist(ped_l) and not IsEntityDead(ped_l) then
		SetEntityHealth(ped_l, 0)
	end
end)

RegisterNetEvent("FaxA:TPToPlayer")
AddEventHandler('FaxA:TPToPlayer', function(Player)
	local src = source
	local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(Player)))

	SetEntityCoords(GetPlayerPed(-1), coords.x, coords.y, coords.z, 1, 0, 0, 1)
end)

RegisterNetEvent('FaxA:SendPlayerReport')
AddEventHandler('FaxA:SendPlayerReport', function(reportingParty, reportedPerson, message)
	TriggerServerEvent("FaxA:SendReportToAdmins", reportingParty, reportedPerson, message)
end)

-------------------------------------------------------------------
RegisterNetEvent("FaxA:FreezePlayer")
AddEventHandler('FaxA:FreezePlayer', function(toggle)
	local player_l = PlayerId()
	local ped_l = GetPlayerPed(-1)
	if toggle then
		if IsPedInAnyVehicle(ped_l) then
			ClearPedTasksImmediately(ped_l)
			Citizen.Wait(0)
		end
		pos_frozen = GetEntityCoords(ped_l, false)
	else
		if not IsPedInAnyVehicle(ped_l) then
			SetEntityCollision(ped_l, true)
		end
		
		SetEntityCollision(ped_l, true)
		FreezeEntityPosition(ped_l, false)
		SetPlayerInvincible(player_l, false)
		pos_frozen = {}
	end
	isFrozen = toggle
end)

RegisterNetEvent('FaxA:SendAdminRadioMessageClient')
AddEventHandler('FaxA:SendAdminRadioMessageClient', function(src, message)
	TriggerServerEvent("FaxA:SendAdminRadioMessageServer", src, message)
end)

RegisterNetEvent('FaxA:GetAdminList')
AddEventHandler('FaxA:GetAdminList', function(returnPlayer)
	if not adminInvisSet then
		TriggerServerEvent("OFRP:ReturnAdminList", returnPlayer)
	end
end)

Citizen.CreateThread(function()
	while true do
		
		local player_l = PlayerId()
		local ped_l = GetPlayerPed(-1)
		if DoesEntityExist(ped_l) then
            
			ManageFrozenPlayer()

		end			
		Citizen.Wait(0)
	end
end)