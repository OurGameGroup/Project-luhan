ClassProgress = require("app.ui.Progress")
local Enemy1 = class("Enemy1", function()
    return display.newScene("Enemy1")
 	
end)
 
function Enemy1:ctor()
	self.bloodpercents = 100
	self.curvePathX = 1
	local base = getRandomFloat(0.2, 0.6)
	self.pathNum = getRandomInt(1, 4)
	self.startx = display.width
	self.starty = getRandomFloat(0,display.height)
	
	self.sprite = display.newSprite("image/enemy/enemy-air2.png")
	self.scale = base+0.3
 	self.sprite:scale(self.scale)
	self.sprite:rotation(0)
	self.sprite:setPosition(self.startx,self.starty)
	self:addChild(self.sprite)

	self.speed= 1500-(self.scale*1400)
	self.fpspeed=self.speed/120

	if self.pathNum == 1 then
		self:Path1()
	elseif self.pathNum == 2 then
		self:Path2()
	elseif self.pathNum == 3 then
		self:Path3()
	elseif self.pathNum == 4 then
		self.starty = getRandomFloat(display.height*3/8,display.height*5/8)
	end

	self:blood()
end

function Enemy1:init()

end

function Enemy1:getX()
	return self.sprite:getPositionX()
end

function Enemy1:getY()
	return self.sprite:getPositionY()
end

function Enemy1:getWidth()
	return self.sprite:getContentSize().width*self.scale
end

function Enemy1:getHeight()
	return self.sprite:getContentSize().height*self.scale
end

function Enemy1:getLeft()
	return self.sprite:getPositionX()-self.sprite:getContentSize().width*self.scale/2
end

function Enemy1:getRight()
	return self.sprite:getPositionX()+self.sprite:getContentSize().width*self.scale/2
end

function Enemy1:getTop()
	return self.sprite:getPositionY()+self.sprite:getContentSize().height*self.scale/2
end

function Enemy1:getBottom()
	return self.sprite:getPositionY()-self.sprite:getContentSize().height*self.scale/2
end

function Enemy1:getBlood()
	return self.bloodpercents
end

function Enemy1:blood()
	self.progress = ClassProgress.new("image/state/EnemybloodTrough.png", "image/state/Enemyblood.png")
	self.progress:setScale(self.scale*0.5/1.3)
	local size = self:getContentSize()
	self.progress:setPosition(size.width*2/3, size.height + self.progress:getContentSize().height/2)
	self:addChild(self.progress)
end

function Enemy1:bloodReset()
	self.bloodpercents = self.bloodpercents - 50
	self.progress:setProgress(self.bloodpercents)
end

function Enemy1:update()
	local x=self.sprite:getPositionX()
	local y=self.sprite:getPositionY()

	if self.pathNum == 1 then
		self.sprite:setPositionX(x-self.fpspeedx)
		self.sprite:setPositionY(y)

		self.progress:setPositionX(x-self.fpspeedx)
		self.progress:setPositionY(y)
	elseif self.pathNum == 2 then
		self.sprite:setPositionX(x-self.fpspeedx)
		self.sprite:setPositionY(y-self.fpspeedy)

		self.progress:setPositionX(x-self.fpspeedx)
		self.progress:setPositionY(y-self.fpspeedy)
	elseif self.pathNum == 3 then
		self.sprite:setPositionX(x-self.fpspeedx)
		self.sprite:setPositionY(y+self.fpspeedy)

		self.progress:setPositionX(x-self.fpspeedx)
		self.progress:setPositionY(y+self.fpspeedy)
	elseif self.pathNum == 4 then
		self.fpspeedx = self.fpspeed
		self.fpspeedy = 5*math.sin(self.curvePathX/50)
		self.sprite:setPositionX(x-self.fpspeedx)
		self.sprite:setPositionY(y+self.fpspeedy)

		self.progress:setPositionX(x-self.fpspeedx)
		self.progress:setPositionY(y+self.fpspeedy)
		self.curvePathX = self.curvePathX + self.fpspeedx
	end

end


function Enemy1:Path1()
	self.fpspeedx=self.fpspeed*self.startx/math.sqrt(self.startx*self.startx+self.starty*self.starty)
end

function Enemy1:Path2()
	local change=getRandomFloat(0.0, 1.0)
	self.fpspeedx=self.fpspeed*self.startx/math.sqrt(self.startx*self.startx+self.starty*self.starty)
	self.fpspeedy=self.fpspeed*self.starty*change/math.sqrt(self.startx*self.startx+self.starty*self.starty)
end

function Enemy1:Path3()
	local change=getRandomFloat(0.0, 1.0)
	self.fpspeedx=self.fpspeed*self.startx/math.sqrt(self.startx*self.startx+self.starty*self.starty)
	self.fpspeedy=self.fpspeed*(display.height-self.starty)*change/math.sqrt(self.startx*self.startx+self.starty*self.starty)
end

function Enemy1:Path4()

end

function getRandomFloat(x,y)
	return math.random()*(y-x)+x
end

function getRandomInt(x,y)
	return math.random(x,y)
end
 
return Enemy1