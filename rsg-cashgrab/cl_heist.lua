local RSGCore = exports['rsg-core']:GetCoreObject()
local timeOut = false

local function InitZones()
    for k,v in pairs(Config.TargetLocations) do
        exports["rsg-target"]:AddBoxZone("snatta_"..k, vector3(v.coords.x, v.coords.y, v.coords.z), 1.7, 1.0, {
            name = "snatta_"..k,
            heading = v.coords.w,
            minZ = v.coords.z - 1,
            maxZ = v.coords.z + 1,
            debugPoly = false,
        }, {
            options = {
                {
                    icon = 'fas fa-user-secret',
                    label = Config.Translations.Target,
                    event = "sw-bank:client:startlift",
                },
            },
            distance = 1.5
        })
    end
end

local function loadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      Wait(5)
  end
end

local function AttemptPoliceAlert()
    if not AlertSend then
        local chance = Config.PoliceAlertChance
        if GetClockHours() >= 0 and GetClockHours() <= 12 then
            chance = Config.PoliceNightAlertChance
        end
        if math.random() <= chance then
            TriggerServerEvent('rsg-lawman:server:lawmanAlert', 'People are searching the bank')
        end
        AlertSend = true
        SetTimeout(Config.AlertCooldown, function()
            AlertSend = false
        end)
    end
end


AddEventHandler('RSGCore:Client:OnPlayerLoaded', function()
    InitZones()
end)

AddEventHandler('sw-bank:server:setTimeout', function()
    if timeOut then return end
    timeOut = true
    CreateThread(function()
        SetTimeout(60000 * Config.Cooldown, function()
            timeOut = false
        end)
    end)
end)

AddEventHandler('sw-bank:client:startlift', function()
        if timeOut then TriggerEvent('rNotify:NotifyLeft', "you only just", "searched", "generic_textures", "tick", 4000) return end
        AttemptPoliceAlert("steal")
		TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_CROUCH_INSPECT"), -1, true, "StartScenario", 0, false)
	    ClearPedTasks(PlayerPedId())
        RSGCore.Functions.Progressbar("searching", Config.Translations.ShopliftProgressbar, 12500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
        local chance = math.random(100)
        if chance <= Config.Chance then
            local current = "U_M_M_SDTRAPPER_01"
            RequestModel(current)
            while not HasModelLoaded(current) do
                Wait(0)
            end
            local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
            x = x +  math.random(100, 100)
            y = y +  math.random(100, 100)
            
            TriggerServerEvent('sw-bank:server:giveItem')
        else
            TriggerServerEvent('sw-bank:server:giveItem')
        end
    end, function() -- Cancel
        timeOut = false
        RSGCore.Functions.Notify(Config.Translations.canceled, "error")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)
    TriggerEvent('sw-bank:server:setTimeout')
end)

AddEventHandler('onResourceStart', function(resource)
   if resource == GetCurrentResourceName() then
      Wait(100)
      InitZones()
   end
end)