Config = {}

Config.Debug = true

-- ════════════════════════════════════════════════════════════════════════════════════ --
--                               RageUI Menü Position                              
-- ════════════════════════════════════════════════════════════════════════════════════ --

Config.MenuPosition = "right" -- "right" / "left"

-- ════════════════════════════════════════════════════════════════════════════════════ --
--                                Depot Coords                               
-- ════════════════════════════════════════════════════════════════════════════════════ --

Config.DepotPoint = {
    {Label = "LS Logistics", Coords = vector4(1014.18, -2523.53, 28.31, 90.01)}
}

Config.needJob = true 

Config.Health = "engine" -- "body"

Config.VehSpawnPoint = vector4(983.98, -2530.77, 28.32, 355.00)

Config.TrailerSpwnPoint = vector4(982.92, -2543.71, 28.3, 355.00)

Config.EndPoint = vector3(1022.34, -2493.32, 28.5)

Config.Cooldown = 10 -- in min 

Config.TxdBug = true

-- ════════════════════════════════════════════════════════════════════════════════════ --
--                                Touren Coords                               
-- ════════════════════════════════════════════════════════════════════════════════════ --

Config.Routen = {
    {Label = "Klärwerk ~y~(Rancho)",                price = "~g~80$", Coords = vector3(476.01, -2151.01, 5.93),     Reward = 80},
    {Label = "Bauernhof ~y~(Sandy Shores)",         price = "~g~300$", Coords = vector3(-128.23, 1927.81, 196.95),  Reward = 300},
    {Label = "Cluckin Bell Fabrik ~y~(Paleto Bay)", price = "~g~600$", Coords = vector3(193.21, 6403.46, 31.35),    Reward = 600},
    {Label = "Sägewerk ~y~(Paleto Bay)",            price = "~g~600$", Coords = vector3(-598.67, 5343.73,  69.68),  Reward = 600},
    {Label = "Baustelle ~y~(Little Seoul)",         price = "~g~90$", Coords = vector3(-473.43, -1020.91,  23.59),  Reward = 90},
    {Label = "Werkstatt ~y~(Paleto Bay)",           price = "~g~600$", Coords = vector3(69.46, 6490.27, 31.25),     Reward = 600},
    {Label = "Golfplatz ~y~(Innenstadt)",           price = "~g~300$", Coords = vector3(-1383.09, 96.68,54.57),     Reward = 300},
    {Label = "Hafen ~y~(Terminal)",                 price = "~g~85$", Coords = vector3(1204.33, -2971.57, 5.9),     Reward = 85},
    {Label = "Hafen ~y~(La Puerta)",                price = "~g~100$", Coords = vector3(-854.08, -1256.81, 5.0),    Reward = 100},
    {Label = "Power-Station ~y~(Route 15)",         price = "~g~320$", Coords = vector3(2683.1, 1599.81, 24.51),    Reward = 320},
    {Label = "Tankstelle ~y~(Grove Street)",        price = "~g~90$", Coords = vector3(-25.85, -1758.78, 29.24),    Reward = 90},
    {Label = "Tankstelle ~y~(Mirror Park)",         price = "~g~95$", Coords = vector3(1170.9, -316.5, 69.18),      Reward = 95},
    {Label = "Tankstelle ~y~(Sandy Shores)",        price = "~g~450$", Coords = vector3(1978.82, 3783.74, 32.18),   Reward = 450},
    {Label = "Tankstelle ~y~(Paleto Bay)",          price = "~g~600$", Coords = vector3(200.99, 6617.44, 31.7),     Reward = 600},
}

-- ════════════════════════════════════════════════════════════════════════════════════ --
--                            Random Trailer / Truck                            
-- ════════════════════════════════════════════════════════════════════════════════════ --

Config.Trailers = {
    {spwn = "trailers"},
    {spwn = "trailers2"},
    {spwn = "trailers"},
}

Config.Trucks = {
    {spwn = "phantom"},
}

