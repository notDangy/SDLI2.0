local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

local weather = "Sunny" -- default weather when starting up the server

RegisterServerEvent("vbw:changeweathersv")
AddEventHandler("vbw:changeweathersv", function(weather2) 
    local _source = source
    local User = VorpCore.getUser(_source)
    local _weather = weather2
    if User.getGroup == "admin" then 
        weather = _weather
        TriggerClientEvent('vbw:changeweathercl', -1, weather)
    end
end)



local normalWeathers = {
    
    {name="Clouds", math.random(60*60000,80*60000)},
    {name="Drizzle", math.random(35*60000,45*60000)},
    {name="Fog", math.random(35*60000,45*60000)},
    {name="HighPressure", lasts=math.random(120*60000,140*60000)},
    {name="Overcast", lasts=math.random(120*60000,140*60000)},
    {name="OvercastDark", lasts=math.random(80*60000,90*60000)},
    {name="Rain", lasts=math.random(30*60000,40*60000)},
    {name="Shower", lasts=math.random(20*60000,30*60000)},
    {name="Sleet", math.random(35*60000,45*60000)},
    {name="Sunny", lasts=math.random(120*60000,140*60000)},    
}

Citizen.CreateThread(function() 
    while true do
        math.randomseed(os.time())
        local waitfor = math.random(3600000, 5000000)
        Wait(waitfor)
        local weather1 = math.random(1,11)
        weather = normalWeathers[weather1]
    end
end)

RegisterServerEvent('vbw:requestweather')
AddEventHandler('vbw:requestweather', function() 
    TriggerClientEvent('vbw:changeweathercl', source, weather)
end)