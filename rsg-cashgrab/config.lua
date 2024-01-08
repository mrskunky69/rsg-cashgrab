Config = Config or {}

Config.AlertCooldown = 30000 -- 10 seconds
Config.PoliceAlertChance = 1.00 -- Chance of alerting police during the day
Config.PoliceNightAlertChance = 1.00 -- Chance of alerting police at night (times:01-06)
Config.Cooldown = 3 -- In minutes
Config.Chance = 100 -- What % chance to succeed in steeling something?
Config.Weapon = "weapon_melee_machete" -- What weapon NPC should wield ?
Config.Translations = {
    Target = "Search",
    PoliceAlertMessage = "Ongoing bankheist",
    AlreadyShoplifted = "You have recently robbed",
    ShopliftProgressbar = "Trying to steal something...",
    canceled = "Canceled",
    NothingFound = "You did not find anything speciall to steal...",
}
--- The coords are the shelves in the stores. Currently only 2 stores pre-made ---
Config.TargetLocations = {
        ["Shop1"] = {
            ["coords"] = vector4(-307.14, 774.14, 118.70, 340.05), ---- val
        },
        ["Shop2"] = {
            ["coords"] = vector4(-309.59, 771.53, 118.70, 247.09), ---- val
        },
        ["Shop3"] = {
            ["coords"] = vector4(-815.51, -1273.44, 43.64, 7.57), ---- black
			
        },
        ["Shop4"] = {
            ["coords"] = vector4(-812.38, -1275.42, 43.64, 185.26),  ---- black
            
        },
        ["Shop5"] = {
            ["coords"] = vector4(2644.19, -1296.36, 52.25, 107.79),  ---ST DENIS
			
        },
		["Shop6"] = {
            ["coords"] = vector4(1291.39, -1303.51, 77.04, 359.55), ---RHODES
			
        },

}

Config.Rewards = {
    "moneybag",
    
}