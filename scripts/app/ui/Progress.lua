local Progress = class("Progress", function(background, fill)
	pic = fill
	local progress = display.newSprite(background)
    return progress
end)
 
function Progress:ctor()
    self.fill = display.newProgressTimer(pic, display.PROGRESS_TIMER_BAR)
    self.fill:setMidpoint(CCPoint(0, 0.5))
    self.fill:setBarChangeRate(CCPoint(1.0, 0))
    self.fill:setPosition(self:getContentSize().width/2, self:getContentSize().height/2)
    self:addChild(self.fill)
    self.fill:setPercentage(100)
end
 
function Progress:setProgress(progress)
	self.fill:setPercentage(progress)
end
 
return Progress