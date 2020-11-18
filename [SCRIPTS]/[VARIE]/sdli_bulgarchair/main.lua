local SeatPrompt
local active = false

local SeatGroup = GetRandomIntInRange(0, 0xffffff)

function Seat()
    Citizen.CreateThread(function()
        local str = 'Siediti'
        local wait = 0
        SeatPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(SeatPrompt, 0xC7B5340A)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(SeatPrompt, str)
        PromptSetEnabled(SeatPrompt, true)
        PromptSetVisible(SeatPrompt, true)
        PromptSetHoldMode(SeatPrompt, true)
        PromptSetGroup(SeatPrompt, SeatGroup)
        PromptRegisterEnd(SeatPrompt)
    end)
end

local target

Props = {
    {"P_CHAIRCOMFY04X", "GENERIC_SEAT_CHAIR_SCENARIO"} ,
    {"P_SIT_CHAIRWICKER01B", "GENERIC_SEAT_CHAIR_SCENARIO"} ,
    {"P_SIT_CHAIRWICKER01A", "GENERIC_SEAT_CHAIR_SCENARIO"} ,
    {"P_CHAIRWICKER01X", "GENERIC_SEAT_CHAIR_SCENARIO"} ,
    {"P_CHAIRROCKING06X", "GENERIC_SEAT_CHAIR_SCENARIO"} ,
    --{"P_WINDSORCHAIR03X", "GENERIC_SEAT_CHAIR_SCENARIO"} ,
    {"P_CHAIR06X", "GENERIC_SEAT_CHAIR_SCENARIO"} ,
    {"P_CHAIR22X", "GENERIC_SEAT_CHAIR_SCENARIO"} ,
    {"P_WOODENCHAIR01X", "GENERIC_SEAT_CHAIR_SCENARIO"} ,
    {"P_WINDSORCHAIR02X", "GENERIC_SEAT_CHAIR_SCENARIO"} ,
    {"P_LOVESEAT01X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_BENCH06X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_BENCH17X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_COUCH05X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_COUCH08X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_BENCHCH01X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_CHAIRFOLDING02X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_CHAIR30X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_BENCH15X", "GENERIC_SEAT_BENCH_SCENARIO"}
}

Citizen.CreateThread(function()
    Wait(2000)
    Seat()
    while true do
        Wait(2)
        for k,v in pairs(Props) do
            local pedCoords = GetEntityCoords(PlayerPedId())
            local ChairId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0 ,GetHashKey(v[1]) , false)
            local chaircoords = GetEntityCoords(ChairId)
            local dist = Vdist(pedCoords, chaircoords)
            SetEntityCanBeDamaged(ChairId, false)
            ClearEntityLastDamageEntity(ChairId)
            SetEntityOnlyDamagedByPlayer(ChairId, false)
            (ChairId, true)
            if dist < 1.5 then
                if active == false then
                    local SeatGroupName  = CreateVarString(10, 'LITERAL_STRING', "Chair")
                    PromptSetActiveGroupThisFrame(SeatGroup, SeatGroupName)
                end
                if PromptHasHoldModeCompleted(SeatPrompt) then
                    active = true
                    target = v
                    local player = PlayerPedId()
                    local chairpos = GetOffsetFromEntityInWorldCoords(ChairId,0.0,0.0,0.5)
                    local chairheading = GetEntityHeading(ChairId)
                    TaskStartScenarioAtPosition(player, GetHashKey(v[2]), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, 0, false)

                end
            else
                if active and v ==target then
                    active = false
                end
            end
        end
    end
end)

RegisterCommand('stand', function(source, args, rawCommand)
	ClearPedTasks(PlayerPedId())
	-- ClearPedTasksImmediately(PlayerPedId())
	Citizen.Wait(2000)
end)
