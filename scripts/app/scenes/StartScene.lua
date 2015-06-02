local StartScene = class("StartScene", function()
    return display.newScene("StartScene")
end)
 
function StartScene:ctor()
    self:setBackground()
    self:setPlayButton()
end

function StartScene:setBackground()
	local background = CCSprite:create("image/background/background1.png")
    background:setPosition(display.cx, display.cy)
    self:addChild(background)
end

function StartScene:setPlayButton()
	local sprite1 = display.newSprite("image/button/play1.png")
    sprite1:setPosition(100,100)
 	sprite1:scale(0.5)
	sprite1:rotation(0)

	local sprite2 = display.newSprite("image/button/play2.png")
    sprite2:setPosition(100,100)
 	sprite2:scale(0.5)
	sprite2:rotation(0)

	item = ui.newImageMenuItem({image=sprite1, imageSelected=sprite2,
    listener = function()
        display.replaceScene(require("app.scenes.MainScene").new(), "fade", 2.0, display.COLOR_WHITE)
    end})
	item:setPosition(display.cx*16/15, display.cy*2/3)
	local menu = ui.newMenu({item})
	menu:setPosition(display.left, display.bottom)
	self:addChild(menu)
end
 
return StartScene