--------------------------------
--- Fax Admin, Made by FAXES ---
--------------------------------
-- Copyright © 2019 FAXES // Fraffel Media

--[[
Default ACE Permission config:
add_ace FaxA.Admin FaxA allow
add_ace FaxA.Mod FaxM allow

add_principal identifier.steam:HEX-ID-HERE FaxA.Admin
add_principal identifier.steam:HEX-ID-HERE FaxA.Mod

------------------------------------------------------

USE THE FOLLOWING VALUES FOR BELOW LEVELS!

0 = Disabled
1 = Allow Admins
2 = Allow Moderators
3 = Allow Both Admins and Moderators

]]

kickLevel = 3               -- Level needed to kick people
banLevel = 3                -- Level needed to ban people
slapLevel = 3               -- Level needed to slap people
freezeLevel = 3             -- Level needed to freeze people
crashLevel = 3              -- Level needed to crash people
tpLevel = 3                 -- Level needed to TP to people
reportsLevel = 3            -- Level needed to see in-game reports and reply to them
adChatLevel = 3             -- Level needed to see admin text chat in-game      
killLevel = 3               -- Level needed to kill people
announceLevel = 1           -- Level needed to make admin announcements


--- Message Config ---
banChatMessage = true       -- Display kick messages in chat when a player is kicked
kickChatMessage = true      -- Display kick messages in chat when a player is kicked

noPermsNote = "~r~Insufficient Permissions"
specifyValidPlayer = "~y~Please specify a player ID."

--- Command Config ---
kickCommand = "kick"
banCommand = "ban"
unBanCommand = "unban"
slapCommand = "slap"
freezeCommand = "freeze"
crashCommand = "crash"
tpCommand = "tp"
reportCommand = "report"
reportReplyCommand = "reply"
adminChatCommand = "ar"
killCommand = "kill"
announcementCommand = "a"
adminsCommand = "admins"
adminInvisCommand = "adinvis"