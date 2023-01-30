function PlayAnim(ped, dict, anim)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
    end

    while not HasAnimDictLoaded(dict) do
        Wait(500)
    end

    FreezeEntityPosition(ped, true)
    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 1, 0, 0, 0, 0)
end

function StopAnim(ped, dict, anim)
    StopAnimTask(ped, dict, anim, 1.0)
    FreezeEntityPosition(ped, false)
end

function GetPlayer()
    TriggerServerEvent("vorp_admin:GetPlayers")
    local playersData = {}
    
    RegisterNetEvent("vorp_admin:SendPlayers", function(result)
        playersData = result
    end)
    
    while next(playersData) == nil do
        Wait(10)
    end
    
    local playerData = {}

    for key, playerInfo in pairs(playersData) do
        if tonumber(playerInfo.serverId) == GetPlayerServerId(PlayerId()) then
            playerData = playerInfo
            break
        end
    end
    return playerData
end

function IsUsingKeyboard(padIndex)
	return Citizen.InvokeNative(0xA571D46727E2B718, padIndex)
end

local function GetClosestPlayer(PlayerPed)
    local players = GetActivePlayers()
    local closestDistance = 2.01
    local closestPlayer = -1
	local closestPed = -1

    for index, player in ipairs(players) do
        local target = GetPlayerPed(tonumber(player))
        if (target ~= PlayerPed) then
            local distance = #(GetEntityCoords(target) - GetEntityCoords(PlayerPed))
            if (closestDistance == -1 or closestDistance > distance) then
                closestPlayer = player
                closestDistance = distance
				closestPed = target
            end
        end
    end

    return closestPlayer, closestPed
end

promptMove = function()

    PromptDelete(Downwards)
    PromptDelete(Upwards)
    PromptDelete(RotateRight)
    PromptDelete(RotateLeft)

    Wait(100)

    Citizen.CreateThread(function()
        local str = "Вперед"
        Forwards = PromptRegisterBegin()
        PromptSetControlAction(Forwards, 0x6319DB71) --Arrow up
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(Forwards, str)
        PromptSetEnabled(Forwards, true)
        PromptSetVisible(Forwards, true)
        PromptSetStandardMode(Forwards, true)
        PromptSetGroup(Forwards, promptGroupMove)
        Citizen.InvokeNative(0x2787CC611D3FACC5, Forwards, true)
        PromptRegisterEnd(Forwards)

        str = "Назад"
        Backwards = PromptRegisterBegin()
        PromptSetControlAction(Backwards, 0x05CA7C52) --Arrow down
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(Backwards, str)
        PromptSetEnabled(Backwards, true)
        PromptSetVisible(Backwards, true)
        PromptSetStandardMode(Backwards, true)
        PromptSetGroup(Backwards, promptGroupMove)
        Citizen.InvokeNative(0x2787CC611D3FACC5, Backwards, true)
        PromptRegisterEnd(Backwards)

        str = "Вправо"
        Rightwards = PromptRegisterBegin()
        PromptSetControlAction(Rightwards, 0xDEB34313) --right arrow
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(Rightwards, str)
        PromptSetEnabled(Rightwards, true)
        PromptSetVisible(Rightwards, true)
        PromptSetStandardMode(Rightwards, true)
        PromptSetGroup(Rightwards, promptGroupMove)
        Citizen.InvokeNative(0x2787CC611D3FACC5, Rightwards, true)
        PromptRegisterEnd(Rightwards)

        str = "Влево"
        Leftwards = PromptRegisterBegin()
        PromptSetControlAction(Leftwards, 0xA65EBAB4) --left arrow
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(Leftwards, str)
        PromptSetEnabled(Leftwards, true)
        PromptSetVisible(Leftwards, true)
        PromptSetStandardMode(Leftwards, true)
        PromptSetGroup(Leftwards, promptGroupMove)
        Citizen.InvokeNative(0x2787CC611D3FACC5, Leftwards, true)
        PromptRegisterEnd(Leftwards)
    end)
end

promptRotate = function()

    PromptDelete(Forwards)
    PromptDelete(Backwards)
    PromptDelete(Rightwards)
    PromptDelete(Leftwards)
    
    Wait(100)

    Citizen.CreateThread(function()
        local str = "Вверх"
        Upwards = PromptRegisterBegin()
        PromptSetControlAction(Upwards, 0x6319DB71) --Arrow up
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(Upwards, str)
        PromptSetEnabled(Upwards, true)
        PromptSetVisible(Upwards, true)
        PromptSetStandardMode(Upwards, true)
        PromptSetGroup(Upwards, promptGroupMove)
        Citizen.InvokeNative(0x2787CC611D3FACC5, Upwards, true)
        PromptRegisterEnd(Upwards)

        local str = "Вниз"
        Downwards = PromptRegisterBegin()
        PromptSetControlAction(Downwards, 0x05CA7C52) --Arrow down
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(Downwards, str)
        PromptSetEnabled(Downwards, true)
        PromptSetVisible(Downwards, true)
        PromptSetStandardMode(Downwards, true)
        PromptSetGroup(Downwards, promptGroupMove)
        Citizen.InvokeNative(0x2787CC611D3FACC5, Downwards, true)
        PromptRegisterEnd(Downwards)

        str = "Вращать вправо"
        RotateRight = PromptRegisterBegin()
        PromptSetControlAction(RotateRight, 0xDEB34313) --right arrow
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(RotateRight, str)
        PromptSetEnabled(RotateRight, true)
        PromptSetVisible(RotateRight, true)
        PromptSetStandardMode(RotateRight, true)
        PromptSetGroup(RotateRight, promptGroupMove)
        Citizen.InvokeNative(0x2787CC611D3FACC5, RotateRight, true)
        PromptRegisterEnd(RotateRight)

        str = "Вращать влево"
        RotateLeft = PromptRegisterBegin()
        PromptSetControlAction(RotateLeft, 0xA65EBAB4) --left arrow
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(RotateLeft, str)
        PromptSetEnabled(RotateLeft, true)
        PromptSetVisible(RotateLeft, true)
        PromptSetStandardMode(RotateLeft, true)
        PromptSetGroup(RotateLeft, promptGroupMove)
        Citizen.InvokeNative(0x2787CC611D3FACC5, RotateLeft, true)
        PromptRegisterEnd(RotateLeft)
    end)
end