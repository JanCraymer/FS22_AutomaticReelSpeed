AutomaticReelSpeed = {}

function AutomaticReelSpeed:onUpdate(dt, isActiveForInput, isActiveForInputIgnoreSelection, isSelected)
    local spec = self.spec_turnOnVehicle

    for i = 1, #spec.turnedOnAnimations do
        local turnedOnAnimation = spec.turnedOnAnimations[i]
        if turnedOnAnimation.name == "reelAnimation" and turnedOnAnimation.isTurnedOn then
            local lastSpeed = math.ceil(self:getLastSpeed())
            local workingSpeedLimit, isWorking = self:getSpeedLimit(true)
            if not isWorking then
                lastSpeed = 6
            elseif lastSpeed < 2 then
                lastSpeed = 2
            elseif lastSpeed > 14 then
                lastSpeed = 14
            end

            turnedOnAnimation.speedScale = (lastSpeed / 10) * 0.7
            if turnedOnAnimation.speedScaleLast ~= nil and turnedOnAnimation.speedScaleLast ~= turnedOnAnimation.speedScale then
                self:setAnimationSpeed(turnedOnAnimation.name, turnedOnAnimation.currentSpeed * turnedOnAnimation.speedScale)
            end
            turnedOnAnimation.speedScaleLast = turnedOnAnimation.speedScale
            spec.turnedOnAnimations[i] = turnedOnAnimation
        end
    end
end

TurnOnVehicle.onUpdate = Utils.appendedFunction(TurnOnVehicle.onUpdate, AutomaticReelSpeed.onUpdate)
