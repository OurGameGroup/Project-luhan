，--
-- Author: Xuluhan
-- Date: 2015-05-18 11:14:47
--
function calsinX(startx,starty,endx,endy)
	return (endy-starty)/math.sqrt((endx-startx)*(endx-startx)+(endy-starty)*(endy-starty))
end

function calcosX(startx,starty,endx,endy)
	return (endx-startx)/math.sqrt((endx-startx)*(endx-startx)+(endy-starty)*(endy-starty))
end

function calAngleToX(cosX,sinX)
	if cosX>=0 and sinX>=0 then
		return math.deg(math.asin(sinX))
	elseif cosX<=0 and sinX>=0 then
		return (180-math.deg(math.asin(sinX)))
	elseif cosX<=0 and sinX<=0 then
		return (180-math.deg(math.asin(sinX)))
	elseif cosX>=0 and sinX<=0 then
		return math.deg(math.asin(sinX))
	end
end

function getFps()
	return 100
end

function getBulletScale()
	return 0.5
end

function InScreen()

end