local Bullet1 = class("Bullet1", function()
    return display.newScene("Bullet1")
 	
end)
 
function Bullet1:ctor()
	
	self.sprite = display.newSprite("image/bullet/bullet2.png")
	self.scale = 0.1
 	self.sprite:scale(self.scale)
	self.sprite:rotation(0)
	self.sprite:setPosition(130,130)
	self:addChild(self.sprite)

	self.speed = 1500
	self.fpspeed = self.speed/120

	
end

function Bullet1:init()

end

function Bullet1:getX()
	return self.sprite:getPositionX()
end

function Bullet1:getY()
	return self.sprite:getPositionY()
end

function Bullet1:getWidth()
	return self.sprite:getContentSize().width
end

function Bullet1:getHeight()
	return self.sprite:getContentSize().height
end

function Bullet1:getLeft()
	return self.sprite:getPositionX()-self.sprite:getContentSize().width*self.scale/2
end

function Bullet1:getRight()
	return self.sprite:getPositionX()+self.sprite:getContentSize().width*self.scale/2
end

function Bullet1:getTop()
	return self.sprite:getPositionY()+self.sprite:getContentSize().height*self.scale/2
end

function Bullet1:getBottom()
	return self.sprite:getPositionY()-self.sprite:getContentSize().height*self.scale/2
end

function Bullet1:update()
	local x=self.sprite:getPositionX()
	local y=self.sprite:getPositionY()
	-- xadd=getRandomFloat(-30,30)
	-- yadd=getRandomFloat(-30,30)
	
	self.sprite:setPositionX(x+self.fpspeed)
	self.sprite:setPositionY(y)
end

return Bullet1