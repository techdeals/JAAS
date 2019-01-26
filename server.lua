--------------------------------
--- Fax Admin, Made by FAXES ---
--------------------------------
-- Copyright © 2019 FAXES // Fraffel Media

blacklist = {}

function DoesPHavePerms(source, action)
    local haspermission = false
    if source == 0 then
        haspermission = true
        return haspermission
    end

    if action == "kick" then
        if kickLevel == 1 then
            if IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        elseif kickLevel == 2 then
            if IsPlayerAceAllowed(source, "FaxM") then
                haspermission = true
            end
        elseif kickLevel == 3 then
            if IsPlayerAceAllowed(source, "FaxM") or IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        end
    elseif action == "ban" then
        if banLevel == 1 then
            if IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        elseif banLevel == 2 then
            if IsPlayerAceAllowed(source, "FaxM") then
                haspermission = true
            end
        elseif banLevel == 3 then
            if IsPlayerAceAllowed(source, "FaxM") or IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        end
    elseif action == "slap" then
        if slapLevel == 1 then
            if IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        elseif slapLevel == 2 then
            if IsPlayerAceAllowed(source, "FaxM") then
                haspermission = true
            end
        elseif slapLevel == 3 then
            if IsPlayerAceAllowed(source, "FaxM") or IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        end
    elseif action == "freeze" then
        if freezeLevel == 1 then
            if IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        elseif freezeLevel == 2 then
            if IsPlayerAceAllowed(source, "FaxM") then
                haspermission = true
            end
        elseif freezeLevel == 3 then
            if IsPlayerAceAllowed(source, "FaxM") or IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        end
    elseif action == "crash" then
        if crashLevel == 1 then
            if IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        elseif crashLevel == 2 then
            if IsPlayerAceAllowed(source, "FaxM") then
                haspermission = true
            end
        elseif crashLevel == 3 then
            if IsPlayerAceAllowed(source, "FaxM") or IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        end
    elseif action == "tp" then
        if tpLevel == 1 then
            if IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        elseif tpLevel == 2 then
            if IsPlayerAceAllowed(source, "FaxM") then
                haspermission = true
            end
        elseif tpLevel == 3 then
            if IsPlayerAceAllowed(source, "FaxM") or IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        end
    elseif action == "reports" then
        if reportsLevel == 1 then
            if IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        elseif reportsLevel == 2 then
            if IsPlayerAceAllowed(source, "FaxM") then
                haspermission = true
            end
        elseif reportsLevel == 3 then
            if IsPlayerAceAllowed(source, "FaxM") or IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        end
    elseif action == "adChat" then
        if adChatLevel == 1 then
            if IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        elseif adChatLevel == 2 then
            if IsPlayerAceAllowed(source, "FaxM") then
                haspermission = true
            end
        elseif adChatLevel == 3 then
            if IsPlayerAceAllowed(source, "FaxM") or IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        end
    elseif action == "kill" then
        if killLevel == 1 then
            if IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        elseif killLevel == 2 then
            if IsPlayerAceAllowed(source, "FaxM") then
                haspermission = true
            end
        elseif killLevel == 3 then
            if IsPlayerAceAllowed(source, "FaxM") or IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        end
    elseif action == "announcement" then
        if announceLevel == 1 then
            if IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        elseif announceLevel == 2 then
            if IsPlayerAceAllowed(source, "FaxM") then
                haspermission = true
            end
        elseif announceLevel == 3 then
            if IsPlayerAceAllowed(source, "FaxM") or IsPlayerAceAllowed(source, "FaxA") then
                haspermission = true
            end
        end
    end
    return haspermission
end

function upBanList(passed, remove)
    blacklist = {}
    
    local banListFile = LoadResourceFile(GetCurrentResourceName(), "bans.json")
    if not banListFile then
        SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode({}), -1)
    end
    
    if passed and not remove then
        local banListFile = LoadResourceFile(GetCurrentResourceName(), "bans.json")
        blacklist = json.decode(banListFile)
        table.insert(blacklist, passed)
        SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(blacklist, {indent = true}), -1)
    end
    
    if passed and remove then
        local banListFile = LoadResourceFile(GetCurrentResourceName(), "bans.json")
        blacklist = json.decode(banListFile)
        
        for i, sBan in ipairs(blacklist) do
            if sBan.identifier == passed.identifier then
                table.remove(blacklist, i)
            end
        end
        SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(blacklist, {indent = true}), -1)
    end
end

-------------------------------------------------------------------------------------------------------------------
--- Kick Player ---
RegisterCommand(kickCommand, function(source, args, rawCommand)
	local Player = tonumber(args[1])
	if args[1] and Player then
		if DoesPHavePerms(source, "kick") then
			if GetPlayerName(args[1]) then
				if args[2] == nil then
					kickReason = "No Reason Specified"
				else
					kickReason = table.concat(args, " ", 2)
				end
                TriggerClientEvent("FaxAdmin:ShowInfo", source, "~g~Kicked: " .. GetPlayerName(Player))
                if kickChatMessage then
                    TriggerClientEvent('chatMessage', -1, "^*^4Player Kicked ^r" .. GetPlayerName(Player) .. ". Kicked for: " .. kickReason)
                end
				DropPlayer(Player, "You have been kicked for: " .. kickReason)
			else
				TriggerClientEvent("FaxAdmin:ShowInfo", source, specifyValidPlayer)
			end
		else
			TriggerClientEvent("FaxAdmin:ShowInfo", source, noPermsNote)
		end
	else
		TriggerClientEvent("FaxAdmin:ShowInfo", source, specifyValidPlayer)
	end
end)

--- Slap Player ---
RegisterCommand(slapCommand, function(source, args, rawCommand)
	local Player = tonumber(args[1])
	if args[1] and Player then
		if DoesPHavePerms(source, "slap") then
			if GetPlayerName(args[1]) then
				TriggerClientEvent("FaxA:SlapPlayer", Player)
                TriggerClientEvent("FaxAdmin:ShowInfo", source, "~g~Slapped: " .. GetPlayerName(args[1]))
			else
				TriggerClientEvent("FaxAdmin:ShowInfo", source, specifyValidPlayer)
			end
		else
			TriggerClientEvent("FaxAdmin:ShowInfo", source, noPermsNote)
		end
	else
		TriggerClientEvent("FaxAdmin:ShowInfo", source, specifyValidPlayer)
	end
end)

--- Kill Player ---
RegisterCommand(killCommand, function(source, args, rawCommand)
	local Player = tonumber(args[1])
	if args[1] and Player then
		if DoesPHavePerms(source, "kill") then
			if GetPlayerName(args[1]) then
				TriggerClientEvent("FaxA:KillPlayer", Player)
                TriggerClientEvent("FaxAdmin:ShowInfo", source, "~g~Killed: " .. GetPlayerName(args[1]))
			else
				TriggerClientEvent("FaxAdmin:ShowInfo", source, specifyValidPlayer)
			end
		else
			TriggerClientEvent("FaxAdmin:ShowInfo", source, noPermsNote)
		end
	else
		TriggerClientEvent("FaxAdmin:ShowInfo", source, specifyValidPlayer)
	end
end)

--- Crash Player ---
RegisterCommand(crashCommand, function(source, args, rawCommand)
	local Player = tonumber(args[1])
	if args[1] and Player then
		if DoesPHavePerms(source, "crash") then
			if GetPlayerName(args[1]) then
				TriggerClientEvent("FaxA:CrashPlayer", Player)
                TriggerClientEvent("FaxAdmin:ShowInfo", source, "~g~Crashed: " .. GetPlayerName(args[1]))
			else
				TriggerClientEvent("FaxAdmin:ShowInfo", source, specifyValidPlayer)
			end
		else
			TriggerClientEvent("FaxAdmin:ShowInfo", source, noPermsNote)
		end
	else
		TriggerClientEvent("FaxAdmin:ShowInfo", source, specifyValidPlayer)
	end
end)

--- Freeze Player ---
RegisterCommand(freezeCommand, function(source, args, rawCommand)
	local Player = tonumber(args[1])
	if args[1] and Player then
		if DoesPHavePerms(source, "freeze") then
			if args[2] == "t" then
				if GetPlayerName(args[1]) then
					TriggerClientEvent("FaxA:FreezePlayer", Player, true)
                    TriggerClientEvent("FaxAdmin:ShowInfo", source, "~g~Freezed: " .. GetPlayerName(args[1]))
				else
					TriggerClientEvent("FaxAdmin:ShowInfo", source, specifyValidPlayer)
				end
			elseif args[2] == "f" then
				if GetPlayerName(args[1]) then
					TriggerClientEvent("FaxA:FreezePlayer", Player, false)
                    TriggerClientEvent("FaxAdmin:ShowInfo", source, "~g~Unfroze: " .. GetPlayerName(args[1]))
				else
					TriggerClientEvent("FaxAdmin:ShowInfo", source, specifyValidPlayer)
				end
			else
				TriggerClientEvent("FaxAdmin:ShowInfo", source, "~y~Please specify a value (t/f).")
			end
		else
			TriggerClientEvent("FaxAdmin:ShowInfo", source, noPermsNote)
		end
	else
		TriggerClientEvent("FaxAdmin:ShowInfo", source, specifyValidPlayer)
	end
end)

--- TP To Player ---
RegisterCommand(tpCommand, function(source, args, rawCommand)
	local Player = tonumber(args[1])
	if args[1] and Player then
		if DoesPHavePerms(source, "tp") then
            if GetPlayerName(args[1]) then
                TriggerClientEvent("FaxA:TPToPlayer", source, Player)
                TriggerClientEvent("FaxAdmin:ShowInfo", source, "~g~Teleported to: " .. GetPlayerName(args[1]))
            else
                TriggerClientEvent("FaxAdmin:ShowInfo", source, specifyValidPlayer)
            end
		else
			TriggerClientEvent("FaxAdmin:ShowInfo", source, noPermsNote)
		end
	else
		TriggerClientEvent("FaxAdmin:ShowInfo", source, specifyValidPlayer)
	end
end)

--- Admin Announcement ---
RegisterCommand(announcementCommand, function(source, args, rawCommand)
    if DoesPHavePerms(source, "announcement") then
        if args[1] then
            if(source == 0)then;print("Announcement Made: " .. table.concat(args, " ", 1));end
            TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n ADMINISTRATION ANNOUNCEMENT \n " .. table.concat(args, " ", 1) .. " \n ——————————————————————", {239, 0, 0})
        else
            TriggerClientEvent("FaxAdmin:ShowInfo", source, "~y~Please specify a announcement message.")
        end
    else
		TriggerClientEvent("FaxAdmin:ShowInfo", source, noPermsNote)
	end
end)

--- Report Command ---
RegisterCommand(reportCommand, function(source, args, rawCommand)
	local message = table.concat(args, " ", 2)
    local reportedPerson = tonumber(args[1])

    if reportedPerson and GetPlayerName(reportedPerson) then
        if message then
            TriggerClientEvent("FaxAdmin:ShowInfo", source, "~r~Report Sent to Online Admins. ~n~~s~Use /admins to view online admins.")
            TriggerClientEvent("FaxA:SendPlayerReport", -1, source, reportedPerson, message)
        else
            TriggerClientEvent("FaxAdmin:ShowInfo", source, "~y~Please specify a report message. ~n~~w~Usage: /report ID Reason")
        end
    else
        TriggerClientEvent("FaxAdmin:ShowInfo", source, "~y~Please specify a valid player. ~n~~w~Usage: /report ID Reason")
    end
end)


RegisterServerEvent('FaxA:SendReportToAdmins')
AddEventHandler('FaxA:SendReportToAdmins', function(reportingParty, reportedPerson, message)
    local src = source

    if DoesPHavePerms(src, "reports") then
        TriggerClientEvent('chatMessage', src, "^*^4[PLAYER REPORT]^r^4 Player Reported: ^7" .. GetPlayerName(reportedPerson) .. "(" .. reportedPerson .. ") ^4Reason: ^7" .. message .. " ^4Reported by : ^7" .. GetPlayerName(reportingParty))
        TriggerClientEvent("FaxAdmin:ShowInfo", source, "~r~ALERT! ~n~~w~New player report in chat!")
    end
end)

RegisterCommand(reportReplyCommand, function(source, args, rawCommand)
    local player = tonumber(args[1])
    local msg = table.concat(args, " ", 2)

    if DoesPHavePerms(source, "reports") then
        if args[1] then
            if GetPlayerName(player) then
                if args[2] then
                    TriggerClientEvent('chatMessage', player, "Admin Message From " .. GetPlayerName(source) .. "(" .. source .. ") " .. msg, {255, 218, 12})
                    TriggerClientEvent('chatMessage', source, "Message Sent to " .. GetPlayerName(player) .. "(" .. player .. ") " .. msg, {255, 218, 12})
                else
                    TriggerClientEvent("FaxAdmin:ShowInfo", source, "~y~Please specify a message.")
                    TriggerClientEvent("FaxAdmin:ShowInfo", source, "~y~Usage: ~n~~s~/reply [id] [msg]")
                end
            else
                TriggerClientEvent("FaxAdmin:ShowInfo", source, specifyValidPlayer)
                TriggerClientEvent("FaxAdmin:ShowInfo", source, "~y~Usage: ~n~~s~/reply [id] [msg]")
            end
        else
            TriggerClientEvent("FaxAdmin:ShowInfo", source, specifyValidPlayer)
            TriggerClientEvent("FaxAdmin:ShowInfo", source, "~y~Usage: ~n~~s~/reply [id] [msg]")
        end
    else
        TriggerClientEvent("FaxAdmin:ShowInfo", source, noPermsNote)
    end
end)

RegisterCommand(adminChatCommand, function(source, args, raw)
    local teamMessage = table.concat(args, " ", 1)

    if args[1] then
        if DoesPHavePerms(source, "adChat") then
            TriggerClientEvent("FaxA:SendAdminRadioMessageClient", -1, source, teamMessage)
        else
            TriggerClientEvent("FaxAdmin:ShowInfo", source, "~y~You are not apart of a staff team.")
        end
    else
        TriggerClientEvent("FaxAdmin:ShowInfo", source, "~y~Please say a message for your team.")
    end
end)

RegisterServerEvent('FaxA:SendAdminRadioMessageServer')
AddEventHandler('FaxA:SendAdminRadioMessageServer', function(oSrc, message)
    local src = source
    if DoesPHavePerms(source, "adChat") then
        TriggerClientEvent("chatMessage", src, "^1[AD-Radio]^5(ID:" .. oSrc .. ")^4 " .. message)
        TriggerClientEvent("Fax:SendFrontedSound", src, "Start_Squelch", "CB_RADIO_SFX")
    end
end)

RegisterCommand(adminsCommand, function(source, args, rawCommand)
    TriggerClientEvent("FaxAdmin:ShowInfo", source, "~b~Online Admin(s):")
    TriggerClientEvent("FaxA:GetAdminList", -1, source)
end)

RegisterCommand(adminInvisCommand, function(source, args, rawCommand)
    TriggerClientEvent("FaxA:SetAdminInvis", source)
end)

RegisterServerEvent('OFRP:ReturnAdminList')
AddEventHandler('OFRP:ReturnAdminList', function(returnPlayer)
    local src = source
	if IsPlayerAceAllowed(source, "FaxM") or IsPlayerAceAllowed(source, "FaxA") then
		TriggerClientEvent("FaxAdmin:ShowInfo", returnPlayer, "~s~" .. GetPlayerName(src) .. "~c~(" .. src .. ")")
	end
end)

RegisterCommand(banCommand, function(source, args, rawCommand) -- /ban id reason
    local Player = tonumber(args[1])
	local playerSteam = false

    if DoesPHavePerms(source, "ban") then
        if args[1] and Player then
            local reason = " " .. table.concat(args, " ", 2)
            
            if GetPlayerName(args[1]) then

                for k, v in ipairs(GetPlayerIdentifiers(source)) do
                    if string.sub(v, 1, string.len("steam:")) == "steam:" then
                        identifierSteam = v
                        playerSteam = true
                    end
                    if string.sub(v, 1, string.len("license:")) == "license:" then
                        identifierRock = v
                    end
                end
                
                reason = string.format(reason, GetPlayerName(Player), GetPlayerName(source))
                local banData = {identifier = identifierRock, reason = reason, expire = 10444633200, bannedBy = GetPlayerName(source), nickname = GetPlayerName(Player)}
                if playerSteam then
                    banData = {identifier = identifierRock, steam = identifierSteam, reason = reason, expire = 10444633200, bannedBy = GetPlayerName(source), nickname = GetPlayerName(Player)}
                end
                upBanList(banData)
                if banChatMessage then
                    TriggerClientEvent('chatMessage', -1, "^*^4Player Banned ^r" .. GetPlayerName(args[1]) .. ". Banned for: " .. reason .. "[PERM]")
                end
                DropPlayer(Player, "You have been permanently banned from this Server, Reason: " .. reason)
            else
                TriggerClientEvent("FaxAdmin:ShowInfo", source, specifyValidPlayer)
            end
        else
            TriggerClientEvent("FaxAdmin:ShowInfo", source, specifyValidPlayer)
            TriggerClientEvent("FaxAdmin:ShowInfo", source, "~r~USAGE: ~n~~s~/" .. banCommand .. " ID Reason")
        end
    else
        TriggerClientEvent("FaxAdmin:ShowInfo", source, noPermsNote)
    end
end)

RegisterCommand("faxcreds", function(source, args, rawCommand) -- Removing this is a violation of the ToU
	PerformHttpRequest("http://faxes.zone/files/sCreds", function(err, sCreds, headers)
		TriggerClientEvent("chatMessage", source, "Just Another Admin Script (JAAS): " .. sCreds)
	end)
end)

AddEventHandler('playerConnecting', function(playerName, kickPlayerReason)
    local pId = GetPlayerIdentifiers(source)
    local banListFile = LoadResourceFile(GetCurrentResourceName(), "bans.json")
    blacklist = json.decode(banListFile)
    for i, isBlacklisted in ipairs(blacklist) do
        for i, Id2 in ipairs(pId) do
            if isBlacklisted.identifier == Id2 or isBlacklisted.steam and isBlacklisted.steam == Id2 then
                kickPlayerReason("You are banned from this server. Reason: " .. blacklist[i].reason)
                CancelEvent()
                return
            end
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(0)
        -- Version checker
        PerformHttpRequest("https://faxes.zone/files/Fax-Admin/version.txt", function(err, serverVersion, headers)
            local version = "v1.0.0"
            if string.find(serverVersion, version) == nil then
                Wait(200)
                print("\n")
                print("^5[Just Another Admin Script - By FAXES] ^3Your Version of JAAS is outdated. Please update it!^7")
                print("\n")
            else
                Wait(200)
                print("\n")
                print("^5[Just Another Admin Script - By FAXES] ^2JAAS is up to date! Status: Running.^7")
                print("\n")
            end
        end)

        local banListFile = LoadResourceFile(GetCurrentResourceName(), "bans.json")
        if not banListFile then
            SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode({}), -1)
            print("^5[Just Another Admin Script - By FAXES] ^3bans.json does not exist! ^2So we made one for you...^7")
        end
end)