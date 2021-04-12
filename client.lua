Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100000)
    end
end)

exports('discord', function(message, color, channel)
    TriggerServerEvent('clienttidiscordi', message, color, channel)
end)
