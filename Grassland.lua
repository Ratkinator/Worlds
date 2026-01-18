-- World 1 Tween System (Grassland)
local World1Tween = {}

-- Check if zone mobs are dead
World1Tween.areMobsDead = function(zoneName)
    local zone = workspace:FindFirstChild(zoneName)
    if not zone then return true end
    
    local zonePos
    if zone:IsA("BasePart") then
        zonePos = zone.Position
    elseif zone:IsA("Model") and zone.PrimaryPart then
        zonePos = zone.PrimaryPart.Position
    else
        local part = zone:FindFirstChildWhichIsA("BasePart")
        if not part then return true end
        zonePos = part.Position
    end
    
    -- Simple mob check
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
            if obj.Humanoid.Health > 0 then
                local mobPos = obj.PrimaryPart and obj.PrimaryPart.Position
                if mobPos and (mobPos - zonePos).Magnitude < 75 then
                    return false
                end
            end
        end
    end
    return true
end

-- Get next zone position
World1Tween.getNextZonePosition = function(currentZone)
    local zoneNum = tonumber(currentZone)
    if not zoneNum then return nil end
    
    local nextZoneNum = zoneNum + 1
    if nextZoneNum > 23 then return nil end
    
    local nextZone = workspace:FindFirstChild(tostring(nextZoneNum))
    if not nextZone then return nil end
    
    local pos
    if nextZone:IsA("BasePart") then
        pos = nextZone.Position
    elseif nextZone:IsA("Model") and nextZone.PrimaryPart then
        pos = nextZone.PrimaryPart.Position
    else
        local part = nextZone:FindFirstChildWhichIsA("BasePart")
        if not part then return nil end
        pos = part.Position
    end
    
    return pos + Vector3.new(0, 10, 0)
end

return World1Tween
