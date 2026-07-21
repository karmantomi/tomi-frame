-- ====================================
-- TOMI FRAMEWORK - SHARED CONFIG
-- ====================================

Config = {}

-- ====================================
-- SERVER SETTINGS
-- ====================================
Config.ServerName = "Tomi Framework Server"
Config.MaxPlayers = 32
Config.Language = "hu" -- 'hu' or 'en'

-- ====================================
-- DATABASE SETTINGS
-- ====================================
Config.Database = {
    host = "localhost",
    user = "fivem",
    password = "password123",
    database = "tomi_framework"
}

-- ====================================
-- CURRENCY & ECONOMY
-- ====================================
Config.Currency = "$"
Config.CurrencySymbol = "$"
Config.StartingMoney = 1000
Config.StartingBank = 5000

-- ====================================
-- JOBS
-- ====================================
Config.Jobs = {
    unemployed = {
        label = "Munkanélküli",
        salary = 0,
        canBuy = false
    },
    police = {
        label = "Rendőr",
        salary = 500,
        canBuy = false
    },
    mechanic = {
        label = "Szerelő",
        salary = 300,
        canBuy = true,
        price = 1000
    },
    taxi = {
        label = "Taxi Sofőr",
        salary = 200,
        canBuy = true,
        price = 500
    },
    doctor = {
        label = "Orvos",
        salary = 400,
        canBuy = false
    },
    dealer = {
        label = "Kereskedő",
        salary = 250,
        canBuy = true,
        price = 2000
    }
}

-- ====================================
-- HOUSING PRICES
-- ====================================
Config.HousingPrices = {
    small = 50000,
    medium = 100000,
    large = 250000,
    mansion = 500000
}

-- ====================================
-- VEHICLE PRICES
-- ====================================
Config.VehiclePrices = {
    oracle = 45000,
    fugitive = 55000,
    granger = 35000,
    asea = 30000,
    dilettante = 25000,
    schafter = 65000,
    felon = 40000,
    tailgater = 50000,
}

-- ====================================
-- SHOPS & MERCHANTS
-- ====================================
Config.Shops = {
    market1 = {
        name = "24/7 Market",
        coords = vector3(25.0, -1347.0, 29.5),
        heading = 0.0,
        items = {"bread", "water", "coffee", "phone"}
    },
    market2 = {
        name = "Cluckin Bell",
        coords = vector3(136.56, -1708.89, 29.3),
        heading = 315.0,
        items = {"burger", "chicken", "fries", "drink"}
    },
    clothes = {
        name = "Binco Clothes",
        coords = vector3(425.4, -982.7, 29.3),
        heading = 0.0,
        items = {"shirt", "pants", "shoes", "hat"}
    }
}

-- ====================================
-- SPAWN LOCATIONS
-- ====================================
Config.SpawnLocations = {
    default = vector3(425.4, -982.7, 29.3),
    police = vector3(425.4, -982.7, 29.3),
    hospital = vector3(333.58, -1431.48, 45.51)
}

-- ====================================
-- INVENTORY LIMITS
-- ====================================
Config.InventorySlots = 20
Config.InventoryWeight = 100 -- kg

-- ====================================
-- MISSION REWARDS
-- ====================================
Config.MissionRewards = {
    taxi = {
        money = 50,
        experience = 10
    },
    delivery = {
        money = 100,
        experience = 25
    },
    police = {
        money = 200,
        experience = 50
    }
}

-- ====================================
-- KEYBINDS
-- ====================================
Config.Keybinds = {
    openInventory = 'I',
    openJob = 'J',
    openPhone = 'P',
    cash = 'K'
}

return Config
