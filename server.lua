ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local alreadylogged = {}

AddEventHandler("esx:playerLoaded", function(source)
    if not alreadylogged[source] then
        local xPlayer = ESX.GetPlayerFromId(source)
        local nimi = xPlayer.getName()
        local ryhma = xPlayer.getGroup()
        local tyo = xPlayer.job.label
        local arvo = xPlayer.job.grade_label
        local Rahat = xPlayer.getMoney()
        local aseet = xPlayer.getLoadout().name
        local aseetlogi = json.encode(aseet)
        local Pankki = xPlayer.getAccount('bank').money
        local Paskaset = xPlayer.getAccount('black_money').money
        local ip = GetPlayerEndpoint(source)
        local ping = GetPlayerPing(source)
        local ids = ExtractIdentifiers(source)
        if Config.xblID then xblID ="\n**Xbox ID:  ** " ..ids.xbl.."" else xblID = "" end
        if Config.steamID then _steamID ="\n**Steam ID:  ** " ..ids.steam.."" else _steamID = "" end
        if Config.liveID then _liveID ="\n**Live ID:  ** " ..ids.live.."" else _liveID = "" end
        if Config.playerID then _playerID ="\n**Player ID:  ** " ..source.."" else _playerID = "" end
        if Config.discordID then _discordID ="\n**Discord ID:  ** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "" end
        if Config.licenseID then _licenseID ="\n**License ID:  ** " ..ids.license.."" else _licenseID = "" end
        if Config.steamURL then _steamURL ="\n\n **Steam Url  **https://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "" end
        renterdiscord('**Pelaaja yhdisti palvelimelle**: ' ..nimi.. '\n' .._playerID.. '\n ' .._steamID.. ' ' .._steamURL.. '\n' .._discordID.. '\n'.._licenseID.. '\n' ..xblID.. '\n' .._liveID.. '\n\n**IP:**' ..ip.. '\n\n**Pinggi:** ' ..ping.. '\n\n**Ryhmä:**' ..ryhma..'\n\n**Käteinen: **' ..Rahat..'\n\n**Pankki: **' ..Pankki..'\n\n**Likainen raha: **' ..Paskaset..'\n\n**Työ: **' ..tyo..'\n\n**Työn arvo: **' ..arvo..'\n\n**Aseet: **' ..aseetlogi..'')
        alreadylogged[source] = true
    end
end) 

function renterdiscord(message)
	local content = {
        {
        	["color"] = '3863105',  
            ["title"] = "klonkkulogit",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Imit kyrpää kellonaikaan: "..os.date("%x %X %p")
            }, 
        }
    }
  	PerformHttpRequest( "WEBHOOK" , function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end

AddEventHandler("playerDropped", function(reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local nimi = xPlayer.getName()
    local ryhma = xPlayer.getGroup()
    local tyo = xPlayer.job.name
    local arvo = xPlayer.job.grade
    local Rahat = xPlayer.getMoney()
    local Pankki = xPlayer.getAccount('bank').money
    local Paskaset = xPlayer.getAccount('black_money').money
    local ip = GetPlayerEndpoint(source)
    local aseet = xPlayer.getLoadout().name
    local aseetlogi = json.encode(aseet)
    local ping = GetPlayerPing(source)
    local ids = ExtractIdentifiers(source)
    if Config.xblID then xblID ="\n**Xbox ID:  ** " ..ids.xbl.."" else xblID = "" end
    if Config.steamID then _steamID ="\n**Steam ID:  ** " ..ids.steam.."" else _steamID = "" end
    if Config.liveID then _liveID ="\n**Live ID:  ** " ..ids.live.."" else _liveID = "" end
    if Config.playerID then _playerID ="\n**Player ID:  ** " ..source.."" else _playerID = "" end
    if Config.discordID then _discordID ="\n**Discord ID:  ** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "" end
    if Config.licenseID then _licenseID ="\n**License ID:  ** " ..ids.license.."" else _licenseID = "" end
    if Config.steamURL then _steamURL ="\n\n **Steam Url  **https://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "" end
    rexitdiscord('**Pelaaja painu vittuun servulta: **' ..nimi.. '\n\n**Syy:** '..reason..'\n' .._playerID.. '\n ' .._steamID.. ' ' .._steamURL.. '\n' .._discordID.. '\n'.._licenseID.. '\n' ..xblID.. '\n' .._liveID.. '\n\n**IP:  **' ..ip.. '\n\n**Pinggi:  ** ' ..ping.. '\n\n**Ryhmä:  **' ..ryhma..'\n\n**Käteinen:  **' ..Rahat..'\n\n**Pankkissa rahaa: **' ..Pankki..'\n\n**Likainen raha: **' ..Paskaset..'\n\n**Työ: **' ..tyo..'\n\n**Työn arvo: **' ..arvo..'\n\n**Aseet: **' ..aseetlogi..'')
end) 

function rexitdiscord(message)
	local content = {
        {
        	["color"] = '15874618', 
            ["title"] = "klonkkulogit",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Imit kyrpää kellonaikaan "..os.date("%x %X %p")
                
            }, 
        }
    }
  	PerformHttpRequest( "WEBHOOK" , function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end


function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end
    return identifiers
end
