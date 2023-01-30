local uiopen = false
local cursor = false
local playerInfo = { regNumber = 000001, playerName = 'Bob', playerSurname = 'Marley', playerDob = '10/01/1890' }
local dirc
local anim

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

-- id, name, surname, regnumber
RegisterNetEvent("lmbId:resaveData")
AddEventHandler("lmbId:resaveData", function(id)
    -- print(id.rn, id.name, id.surname, id.birthday)
    playerInfo = { regNumber = id.rn, playerName = id.name, playerSurname = id.surname, playerDob = id.birthday }
end)

AddEventHandler("onClientResourceStart", function (resourceName)
    if resourceName == GetCurrentResourceName() then
        --TriggerServerEvent("lmbNotify:GetJob")
        TriggerServerEvent("lmbNotify:GetGroup")
    end
end)

RegisterNetEvent("vorp:UpdateGroup")
AddEventHandler("vorp:UpdateGroup", function(rgroup)
    print(rgroup)
    PlayerGroup = rgroup
end)

Citizen.CreateThread(function()
    TriggerServerEvent("lmbId:requestData")
    while true do
        Wait(1)
        if IsControlJustPressed(0, 0xE6F612E4) then -- [1]
            uiopen = true

            local player = GetPlayer()
            SendNUIMessage({
                type = 'open-main-menu',
                resource = GetCurrentResourceName(),
                player = playerInfo,
                group = PlayerGroup
            })

            SetNuiFocus(true, true)
            --SetNuiFocusKeepInput(true)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if IsControlPressed(0, 0x1CE6D9EB) then -- [2]
            local player = GetPlayerPed(PlayerId())
            ClearPedTasks(player)
            StopAnim(player, dirc, anim)
            
            PromptDelete(Forwards)
            PromptDelete(Backwards)
            PromptDelete(Rightwards)
            PromptDelete(Leftwards)
            PromptDelete(RotateRight)
            PromptDelete(RotateLeft)
            PromptDelete(ConfirmButton)
            PromptDelete(ChangeType)
            PromptDelete(Upwards)
            PromptDelete(Downwards)
        end
    end
end)

-- Citizen.CreateThread(function()
--     while true do
--         Wait(1)
--         if IsControlPressed(0, 0xCEE12B50) then -- [MOUSE3]
--             print(cursor)
--             if cursor then
--                 cursor = false
--                 SetNuiFocus(true, false)
--             else
--                 cursor = true
--                 SetNuiFocus(true, true)
--                 SetNuiFocusKeepInput(false)
--             end
--         end
--     end
-- end)

-- Запрос на закрытие окна (для кнопки крестика)
RegisterNUICallback('request-to-close', function(args, cb)
    uiopen = false

    SendNUIMessage({
        type = 'close-main-menu'
    })

    SetNuiFocus(false, false)
end)

-- Установить игроку походку
local walkstyle = "MP_Style_Casual"

AddEventHandler("lmbMenu:setWalkStyle", function(walk)
    print(Citizen.InvokeNative(0x498F2E77982D6945, PlayerPedId(), walkstyle))

    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)

    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), walkstyle, 0, -1)
    
    Wait(500)
    walkstyle = walk

    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), walkstyle, 1, -1)
    
    Wait(200)
    print(Citizen.InvokeNative(0x498F2E77982D6945, PlayerPedId(), walkstyle))
end)

RegisterNUICallback('set-player-walk', function(args, cb)
    print(args.walk.walk)
    TriggerEvent("lmbMenu:setWalkStyle", args.walk.walk)
end)

-- Запустить выбранную анимацию
RegisterNUICallback('play-selected-anim', function(args, cb)
    uiopen = false

    local player = PlayerPedId()
    dirc = args.anim.animdirectory
    anim = args.anim.anim

    PlayAnim(player, dirc, anim)

    SendNUIMessage({
        type = 'close-main-menu'
    })
    SetNuiFocus(false, false)

    Citizen.CreateThread(function()
        local str = "Вращать/Высота"
        ChangeType = PromptRegisterBegin()
        PromptSetControlAction(ChangeType, 0x8AAA0AD4) --Left Alt
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(ChangeType, str)
        PromptSetEnabled(ChangeType, true)
        PromptSetVisible(ChangeType, true)
        PromptSetStandardMode(ChangeType, true)
        PromptSetGroup(ChangeType, promptGroupMove)
        Citizen.InvokeNative(0x2787CC611D3FACC5, ChangeType, true)
        PromptRegisterEnd(ChangeType)

        str = "Установить"
        ConfirmButton = PromptRegisterBegin()
        PromptSetControlAction(ConfirmButton, 0x2CD5343E) --Enter
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(ConfirmButton, str)
        PromptSetEnabled(ConfirmButton, true)
        PromptSetVisible(ConfirmButton, true)
        PromptSetStandardMode(ConfirmButton, true)
        PromptSetGroup(ConfirmButton, promptGroupMove)
        Citizen.InvokeNative(0x2787CC611D3FACC5, ConfirmButton, true)
        PromptRegisterEnd(ConfirmButton)

        promptMove()

        local flag = true
        local move = true

        --FreezeEntityPosition(GetPlayerPed(PlayerId()), true)

        local ped, coords = PlayerPedId(), GetEntityCoords(ped)

        local scale = GetExternalKvpFloat("vorp_skinuri", "height")
        print(scale)
        scale = scale - 1.0
        print(scale)
        
        while flag do
            Wait(1)
            coords = GetEntityCoords(ped)
            local forwardVector = vector3(GetEntityForwardX(ped), GetEntityForwardY(ped), 0)
            --print(forwardVector.z)
            local hdg = GetEntityHeading(ped)
            if Citizen.InvokeNative(0xC92AC953F0A982AE, ChangeType) then
                if move then
                    promptRotate()
                    move = false
                else
                    promptMove()
                    move = true
                end
            elseif Citizen.InvokeNative(0xC92AC953F0A982AE, ConfirmButton) then
                PromptDelete(Forwards)
                PromptDelete(Backwards)
                PromptDelete(Rightwards)
                PromptDelete(Leftwards)
                PromptDelete(RotateRight)
                PromptDelete(RotateLeft)
                PromptDelete(ConfirmButton)
                PromptDelete(ChangeType)
                PromptDelete(Upwards)
                PromptDelete(Downwards)
                --FreezeEntityPosition(GetPlayerPed(PlayerId()), false)
                flag = false
            elseif Citizen.InvokeNative(0xC92AC953F0A982AE, Forwards) then
			    ClearPedTasks(PlayerPedId())
                local temp = coords+forwardVector*0.03
                SetEntityCoords(ped, temp.x, temp.y, coords.z-(1+scale))
                print(temp.z, coords.z, 1+scale)
                PlayAnim(player, dirc, anim)
            elseif Citizen.InvokeNative(0xC92AC953F0A982AE, Backwards) then
			    ClearPedTasks(PlayerPedId())
                local temp = coords-forwardVector*0.03
                SetEntityCoords(ped, temp.x, temp.y, coords.z-(1+scale))
                PlayAnim(player, dirc, anim)
            elseif Citizen.InvokeNative(0xC92AC953F0A982AE, Rightwards) then
			    ClearPedTasks(PlayerPedId())
                local temp = coords+vector3(forwardVector.y, -forwardVector.x, 0)*0.03
                SetEntityCoords(ped, temp.x, temp.y, coords.z-(1+scale))
                PlayAnim(player, dirc, anim)
            elseif Citizen.InvokeNative(0xC92AC953F0A982AE, Leftwards) then
			    ClearPedTasks(PlayerPedId())
                local temp = coords+vector3(-forwardVector.y, forwardVector.x, 0)*0.03
                SetEntityCoords(ped, temp.x, temp.y, coords.z-(1+scale))

                PlayAnim(player, dirc, anim)
            elseif Citizen.InvokeNative(0xC92AC953F0A982AE, RotateRight) then
			    ClearPedTasks(PlayerPedId())
                SetEntityHeading(ped, hdg-1)
                PlayAnim(player, dirc, anim)
            elseif Citizen.InvokeNative(0xC92AC953F0A982AE, RotateLeft) then
			    ClearPedTasks(PlayerPedId())
                SetEntityHeading(ped, hdg+1)
                PlayAnim(player, dirc, anim)
            elseif Citizen.InvokeNative(0xC92AC953F0A982AE, Upwards) then
			    ClearPedTasks(PlayerPedId())
                SetEntityCoords(ped, coords.x, coords.y, coords.z + 0.01-(1+scale))
                PlayAnim(player, dirc, anim)
            elseif Citizen.InvokeNative(0xC92AC953F0A982AE, Downwards) then
			    ClearPedTasks(PlayerPedId())
                SetEntityCoords(ped, coords.x, coords.y, coords.z - 0.01-(1+scale))
                PlayAnim(player, dirc, anim)
            end
        end
    end)

end)

function GetClosestPlayer(PlayerPed)
    local players = GetActivePlayers()
    local closestDistance = 2.01
    local closestPlayer = -1

    for index, value in ipairs(players) do
        local target = GetPlayerPed(tonumber(value))
        if (target ~= PlayerPed) then
            local distance = #(GetEntityCoords(GetPlayerPed(value)) - GetEntityCoords(PlayerPed))
            if (closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end

    return closestPlayer
end

RegisterNUICallback('cuff-player', function(args, cb)
    local target = GetClosestPlayer(PlayerPedId())
    local targetPed = GetPlayerPed(target)
    print("here")

    if not IsPedCuffed(targetPed) then
        TriggerServerEvent("lmbSheriff:cuffServer", GetPlayerServerId(target), true)
    end
end)

RegisterNUICallback('search-player', function(args, cb)
    local target, targetPed = GetClosestPlayer(PlayerPedId())

    TriggerServerEvent("lmbSheriff:reloadInventory", GetPlayerServerId(target))
    TriggerServerEvent("lmbSheriff:openInventory", GetPlayerServerId(target))
end)


RegisterNUICallback('uncuff-player', function(args, cb)
    local target = GetClosestPlayer(PlayerPedId())
    local targetPed = GetPlayerPed(target)
    print("here, uncuff")

    if IsPedCuffed(targetPed) then
        TriggerServerEvent("lmbSheriff:cuffServer", GetPlayerServerId(target), false)
    end
end)

RegisterNUICallback('revive-player', function(args, cb)
    local target = GetClosestPlayer(PlayerPedId())
    local targetPed = GetPlayerPed(target)
    print("here, revive")

    if IsPedDeadOrDying(targetPed, 1) then
        TriggerServerEvent("vorpMed:resurrectPlayer", GetPlayerServerId(target))
    end
end)

local radarFlag = true
local markerFlag = true

RegisterNUICallback('set-settings-control-map', function(args, cb)
    radarFlag = not radarFlag
    SetResourceKvp("radar", radarFlag)
    DisplayRadar(radarFlag)
end)

RegisterNUICallback('set-settings-control-markers', function(args, cb)
    markerFlag = not markerFlag
    SetResourceKvp("markers", markerFlag)
    VORPcore.NotifyRightTip("Мы активно работаем над этой функцией",4000)
    --TriggerEvent("markers", markerFlag)
end)

RegisterNUICallback('request-to-control-names', function(args, cb)
    --TriggerEvent("lmbNames:enable")
end)

RegisterNUICallback('request-to-open-give-modal', function(args, cb)
    --TriggerEvent("lmbGive:OpenGiveMenu")
end)

local speed_additive = 0.5

RegisterNUICallback('set-settings-control-walk', function(args, cb)
    if speed_additive == 0.5 then
        speed_additive = 0.05
    else
        speed_additive = 0.5
    end

    SetResourceKvpFloat("speed_additive", speed_additive)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local player = PlayerPedId()
            local speed = 0.5 + speed_additive 
            SetPedMoveRateOverride(player, speed)
            SetPedMaxMoveBlendRatio(player, speed)
            SetPedDesiredMoveBlendRatio(player, speed)
            if IsControlPressed(0, 0x8FFC75D6) then
                SetPedMaxMoveBlendRatio(player, 1.85 + 0.05)
            end
    
            if IsControlPressed(0, 0xF84FA74F) then
                SetPedMaxMoveBlendRatio(player, 1.85 + 0.05)
            end
        end
    end)
end)

Citizen.CreateThread(function()
    markerFlag = GetResourceKvpString("markers")
    radarFlag = GetResourceKvpString("radar")
    speed_additive = GetResourceKvpFloat("speed_additive")
end)

-- Создать тикет/репорт для администрации
RegisterNUICallback('create-report', function(args, cb)
    print(args)
    print(args.reportContent)
    -- Call admin report
    --TriggerEvent("lmbNotify", 3, "Новый тикет", "Тикет отправлен", 10000)
    local webhook = "https://discord.com/api/webhooks/1068867917011226654/kSW7pYGZxItbkLbtXJi9-JfCsq8v4W9EM9AdD8sqM9WbJPC6I9fh5T0Ed840OMckjMS3"
    TriggerServerEvent("vorp_admin:logs", webhook, "Репорт от игрока", report)
    --TriggerServerEvent("NotifyAdminsServer", GetEntityCoords(PlayerPedId()), args.reportContent)
end)

function GetCurrentState()
    local x,y,z =  table.unpack(GetEntityCoords(PlayerPedId()))

    local current_district = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 10)

    local current_state

    for state, districts in pairs(Config.States) do
        for key, hash in pairs(districts) do
            if current_district == hash then
                current_state = state
            end
        end
    end

    return current_state
end

RegisterNUICallback('create-custom-call-police', function(args, cb)
    local state = GetCurrentState()
    
    local coords = GetEntityCoords(PlayerPedId())
    print(args)

    local current_town = Citizen.InvokeNative(0x43AD8FC02B429D33, coords.x, coords.y, coords.z, 1)

    if state == "Ambarino" or state == "NewHanover" then
        local ValentineCoords = vector3(Config.Locations["Valentine"].x, Config.Locations["Valentine"].y, Config.Locations["Valentine"].z)
        local AnnesburgCoords = vector3(Config.Locations["Annesburg"].x, Config.Locations["Annesburg"].y, Config.Locations["Annesburg"].z)

        local distVal, distAnn = #(coords - ValentineCoords), #(coords - AnnesburgCoords)

        coords = vector3(coords.x+GetRandomIntInRange(-Config.Random, Config.Random), coords.y+GetRandomIntInRange(-Config.Random, Config.Random), coords.z+GetRandomIntInRange(-Config.Random, Config.Random))

        print(coords)
        if distVal < distAnn then
            if current_town == 459833523 then
                TriggerServerEvent("NotifyCopsServer", "usmarshall", coords, args.reasonCall)
                TriggerServerEvent("NotifyCustomServer", "valentinesheriff", coords, args.reasonCall)
                return
            end
            if distVal < 1000.0 then
                Wait(60000)
            elseif distVal < 2000.0 then
                Wait(120000)
            else
                Wait(180000)
            end
                TriggerServerEvent("NotifyCopsServer", "usmarshall", coords, args.reasonCall)
                TriggerServerEvent("NotifyCustomServer", "valentinesheriff", coords, args.reasonCall)
        else
            if current_town == 7359335 then
                TriggerServerEvent("NotifyCopsServer", "usmarshall", coords, args.reasonCall)
                TriggerServerEvent("NotifyCustomServer", "annesburgsheriff", coords, args.reasonCall)
                return
            end
            if distAnn < 1000.0 then
                Wait(60000)
            elseif distAnn < 2000.0 then
                Wait(120000)
            else
                Wait(180000)
            end
                TriggerServerEvent("NotifyCopsServer", "usmarshall", coords, args.reasonCall)
                TriggerServerEvent("NotifyCustomServer", "annesburgsheriff", coords, args.reasonCall)
        end
    elseif state == "WestElizabeth" then
        local StrawberryCoords = vector3(Config.Locations["Strawberry"].x, Config.Locations["Strawberry"].y, Config.Locations["Strawberry"].z)
        local BlackwaterCoords = vector3(Config.Locations["Blackwater"].x, Config.Locations["Blackwater"].y, Config.Locations["Blackwater"].z)

        local distStr, distBla = #(coords - StrawberryCoords), #(coords - BlackwaterCoords)

        coords = vector3(coords.x+GetRandomIntInRange(-Config.Random, Config.Random), coords.y+GetRandomIntInRange(-Config.Random, Config.Random), coords.z+GetRandomIntInRange(-Config.Random, Config.Random))

        if distStr < distBla then
            if current_town == 427683330 then
                TriggerServerEvent("NotifyCopsServer", "usmarshall", coords, args.reasonCall)
                TriggerServerEvent("NotifyCustomServer", "strawberrysheriff", coords, args.reasonCall)
                return
            end
            if distStr < 1000.0 then
                Wait(60000)
            elseif distStr < 2000.0 then
                Wait(120000)
            else
                Wait(180000)
            end
                TriggerServerEvent("NotifyCopsServer", "usmarshall", coords, args.reasonCall)
                TriggerServerEvent("NotifyCustomServer", "strawberrysheriff", coords, args.reasonCall)
        else
            if current_town == 1053078005 then
                TriggerServerEvent("NotifyCopsServer", "usmarshall", coords, args.reasonCall)
                TriggerServerEvent("NotifyCustomServer", "blackwaterpolice", coords, args.reasonCall)
                return
            end
            if distBla < 1000.0 then
                Wait(60000)
            elseif distBla < 2000.0 then
                Wait(120000)
            else
                Wait(180000)
            end
                TriggerServerEvent("NotifyCopsServer", "usmarshall", coords, args.reasonCall)
                TriggerServerEvent("NotifyCustomServer", "blackwaterpolice", coords, args.reasonCall)
        end
    elseif state == "Lemoyne" then
        local RhodesCoords = vector3(Config.Locations["Rhodes"].x, Config.Locations["Rhodes"].y, Config.Locations["Rhodes"].z)
        local SaintDenisCoords = vector3(Config.Locations["SaintDenis"].x, Config.Locations["SaintDenis"].y, Config.Locations["SaintDenis"].z)

        local distRds, distStd = #(coords - RhodesCoords), #(coords - SaintDenisCoords)

        coords = vector3(coords.x+GetRandomIntInRange(-Config.Random, Config.Random), coords.y+GetRandomIntInRange(-Config.Random, Config.Random), coords.z+GetRandomIntInRange(-Config.Random, Config.Random))

        if distRds < distStd then
            if current_town == 2046780049 then
                TriggerServerEvent("NotifyCopsServer", "usmarshall", coords, args.reasonCall)
                TriggerServerEvent("NotifyCustomServer", "rhodessheriff", coords, args.reasonCall)
                return
            end
            if distRds < 1000.0 then
                Wait(60000)
            elseif distRds < 2000.0 then
                Wait(120000)
            else
                Wait(180000)
            end
                TriggerServerEvent("NotifyCopsServer", "usmarshall", coords, args.reasonCall)
                TriggerServerEvent("NotifyCustomServer", "rhodessheriff", coords, args.reasonCall)
        else
            if current_town == -765540529 then
                TriggerServerEvent("NotifyCopsServer", "usmarshall", coords, args.reasonCall)
                TriggerServerEvent("NotifyCustomServer", "saintdenispolice", coords, args.reasonCall)
                return
            end
            if distStd < 1000.0 then
                Wait(60000)
            elseif distStd < 2000.0 then
                Wait(120000)
            else
                Wait(180000)
            end
                TriggerServerEvent("NotifyCopsServer", "usmarshall", coords, args.reasonCall)
                TriggerServerEvent("NotifyCustomServer", "saintdenispolice", coords, args.reasonCall)
        end
    end
end)

RegisterNUICallback('create-custom-call-doctor', function(args, cb)
    print(args)
    local coords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("NotifyCustomServer", "doctor", coords, args.reasonCall)
end)
