local Weapon1 = class("Weapon1", function()
    return display.newScene("Weapon1")
 	
end)
 
function Weapon1:ctor()

	sprite1 = display.newSprite("image/weapons/weapon1-1.png")
    sprite1:setPosition(0, 0)
 	sprite1:scale(0.8)
	sprite1:rotation(0)
	self:addChild(sprite1)
    transition.moveTo(sprite1, {x=100, y=100, time=1.5})

end

function Weapon1:update()
    
end

return Weapon1