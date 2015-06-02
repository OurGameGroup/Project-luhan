-- require("app.Function")
-- ClassPlayer = require("app.roles.Player")
ClassEnemy1 = require("app.roles.Enemy1")
ClassBullet1 = require("app.roles.Bullet1")
ClassWeapon1 = require("app.roles.Weapon1")
ClassProgress = require("app.ui.Progress")
pause=1
enemytime=0
rectScreen = {left = -10, right = CONFIG_SCREEN_WIDTH+10, top = CONFIG_SCREEN_HEIGHT, bottom = -10}
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self.blood = 100
	self:setBackground()
    self:setWeapons()
    self:setBlood()
    self:initEnemy1()
    self:initBullet1()
    self:initUpdate()
    self:addTouchLayer()
    
    local sprite1 = display.newSprite("image/button/play1.png")
    sprite1:setPosition(100,100)
    sprite1:scale(0.5)
    sprite1:rotation(0)

    local sprite2 = display.newSprite("image/button/play2.png")
    sprite2:setPosition(100,100)
    sprite2:scale(0.5)
    sprite2:rotation(0)

end

function MainScene:setBackground()
	local background = display.newSprite("image/background/background2.jpg", display.cx, display.cy)
    self:addChild(background)
end

function MainScene:setWeapons()
    self.weapon1 = ClassWeapon1.new()
    self:addChild(self.weapon1)
end

function MainScene:setBlood()
    self.progress = ClassProgress.new("image/state/bloodTrough.png", "image/state/blood.png")
    self.progress:setPosition(display.left + self.progress:getContentSize().width/2, display.top - self.progress:getContentSize().height/2)
    self:addChild(self.progress)
end

function MainScene:resetBlood()
    self.blood = self.blood - 10
    self.progress:setProgress(self.blood)
end

function MainScene:addEnemy1()
	local enemy1 = ClassEnemy1.new()
    table.insert(self._listEnemy1, enemy1)
    self._layerEnemy1:addChild(enemy1)
end

function MainScene:addBullet1()
    local bullet1 = ClassBullet1.new()
    table.insert(self._listBullet1, bullet1)
    self._layerBullet1:addChild(bullet1)
end

function MainScene:initUpdate()
    self._scheduler = require("framework.scheduler")
    self.handle = self._scheduler.scheduleGlobal(handler(self, self.update), 1/120)
end

function MainScene:update()
    enemytime = enemytime + 1
    if enemytime%90 == 0 then
        self:addEnemy1()
    end
    local i = 1
    local count1 = #self._listEnemy1
    while i <= count1 do
        local obj1 = self._listEnemy1[i]
        if obj1:update() then
            table.remove(self._listEnemy1,i)
            obj1:removeSelf()
            count1 = count1 - 1
        else
            i = i + 1
        end
    end

    local j = 1
    local count2 = #self._listBullet1
    while j <= count2 do
        local obj2 = self._listBullet1[j]
        if obj2:update() then
            table.remove(self._listBullet1,j)
            obj2:removeSelf()
            count2 = count2 - 1
        else
            j = j + 1
        end
    end

    local k = 1
    local countAbove1 = #self._listEnemy1
    while k <= countAbove1 do
        local objEnemy1 = self._listEnemy1[k]
        if objEnemy1:getRight()<0 or objEnemy1:getTop()<0 or objEnemy1:getBottom()>640 then
            table.remove(self._listEnemy1,k)
            self:resetBlood()
            if self.blood<=0 then
                self._scheduler.unscheduleGlobal(self.handle)
                display.replaceScene(require("app.scenes.StartScene").new(), "fade", 2.0, display.COLOR_WHITE)
            end
            objEnemy1:removeSelf()
            countAbove1 = countAbove1 - 1
        else
            k = k + 1
        end
    end

    local l = 1
    local countAbove2 = #self._listBullet1
    while l <= countAbove2 do
        local objBullet1 = self._listBullet1[l]
        if objBullet1:getRight()<0 or objBullet1:getLeft()>1136 or objBullet1:getTop()<0 or objBullet1:getBottom()>640 then
            table.remove(self._listBullet1,l)
            objBullet1:removeSelf()
            countAbove2 = countAbove2 - 1
        else
            l = l + 1
        end
    end

    local e = 1
    local ifremove = 0
    local countHit = #self._listEnemy1
    while e <= countHit do
        local b = 1
        local countHit2 = #self._listBullet1
        while b <= countHit2 do
            local objBullet1Hit = self._listBullet1[b]
            local objEnemy1Hit = self._listEnemy1[e]
            if objBullet1Hit:getLeft() <= objEnemy1Hit:getRight() and objBullet1Hit:getRight() >= objEnemy1Hit:getLeft()
                and ((objBullet1Hit:getTop() >= objEnemy1Hit:getBottom() and objBullet1Hit:getTop() <= objEnemy1Hit:getTop()) or (objBullet1Hit:getBottom() >= objEnemy1Hit:getBottom() and objBullet1Hit:getBottom() <= objEnemy1Hit:getTop()))   then
                self._listEnemy1[e]:bloodReset()
                table.remove(self._listBullet1,b)
                objBullet1Hit:removeSelf()
                countHit2 = countHit2 - 1
                if self._listEnemy1[e]:getBlood() <= 0 then
                    ifremove = 1
                    table.remove(self._listEnemy1,e)
                    objEnemy1Hit:removeSelf()
                    break
                end
            else
                b = b + 1 
            end
        end
        if ifremove == 1 then 
            
            countHit = countHit - 1
            ifremove = 0
        else
            e = e + 1
        end
    end
    
end

function MainScene:initEnemy1()
    self._listEnemy1 = {}
    self._layerEnemy1 = display.newNode()
    self:addChild(self._layerEnemy1)
end

function MainScene:initBullet1()
    self._listBullet1 = {}
    self._layerBullet1 = display.newNode()
    self:addChild(self._layerBullet1)
end

function MainScene:addTouchLayer()
    local function onTouch(eventName, x, y)
        if eventName == "began" then
            self:addBullet1()
        end
    end
 
    self.layerTouch = display.newLayer()
    self.layerTouch:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        return onTouch(event.name, event.x, event.y)
    end)
    self.layerTouch:setTouchEnabled(true)
    self.layerTouch:setPosition(ccp(100,100))
    self.layerTouch:setContentSize(100,100)
    self:addChild(self.layerTouch)
end

-- local poplayer = display.newSprite():addTo(self)
--     poplayer:setCascadeBoundingBox(CCRectMake(0, 0, display.width, display.height))
--     poplayer:setTouchEnabled(true)
--     poplayer:addTouchEventListener(function(event, x, y)
--         if event == "began" then
--             return true
--         elseif event == "ended" then
--             print("pop layer touch ended......")
--         end

--     end)

return MainScene