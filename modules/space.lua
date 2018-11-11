space = { x = 2000, y = 2000, xv = 0, yv = 0 }

function generateStars()
  space.stars = {}
  for i = 1,1000 do
    space.stars[i] = {x = love.math.random(1,320), y = love.math.random(1,180), layer = love.math.random(2, 15)}
  end
end

function drawSpace()

  for i = 1, #space.stars do
    love.graphics.setColor(1,1,1,1/space.stars[i].layer)
    love.graphics.rectangle("fill",space.stars[i].x,space.stars[i].y,1,1)
  end

  love.graphics.setColor(1,1,1)

  local nearestplan = -1

  for i = 1, game.planets do
    love.graphics.draw(planetImg[game.planet[i].img].img,game.planet[i].x-space.x,game.planet[i].y-space.y)

    if distanceFrom(game.planet[i].x+8, game.planet[i].y+8, space.x+150, space.y+80) < 16 then
      drawMessageBox("Press <space> to land.",180-32)
      drawMessageBox("Home of the "..game.race[game.planet[i].race].name,180-16)
      love.graphics.draw(raceImg[game.race[game.planet[i].race].img].idle,0,180-32)
      love.graphics.draw(raceImg[game.race[game.planet[i].race].img].idle,320-32,180-32)
    end

    if love.keyboard.isDown(KEY_SCAN) then
      if distanceFrom(game.planet[i].x+8, game.planet[i].y+8, space.x+150, space.y+80) < 600 then love.graphics.line(game.planet[i].x-space.x+16, game.planet[i].y-space.y+16, 150+12, 80+12) nearestplan = 0
      elseif nearestplan < 1 then if distanceFrom(game.planet[i].x+8, game.planet[i].y+8, space.x+150, space.y+80) < nearestplan then nearestplan = distanceFrom(game.planet[i].x+8, game.planet[i].y+8, space.x+150, space.y+80) end end
    end
  end

  if nearestplan > 1 and love.keyboard.isDown(KEY_SCAN) then
    drawMessageBox("Nearest planet: "..nearestplan.." units away",180-16)
  end

  if love.keyboard.isDown(KEY_HELP) then
    love.graphics.print("Use <"..KEY_UP..">, <"..KEY_LEFT..">, <"..KEY_DOWN.."> & <"..KEY_RIGHT.."> to navigate.\nPress <"..KEY_SCAN.."> to scan for planets.")
  else
    love.graphics.print("Hold <"..KEY_HELP.."> for help")
  end

  love.graphics.draw(vehicleImg["ship1"],150,80)
end

function updateSpace(dt)
  local speed = 64*dt
  local drag = 32*dt

  if love.keyboard.isDown(KEY_UP) then space.yv = space.yv - speed end
  if love.keyboard.isDown(KEY_DOWN) then space.yv = space.yv + speed end
  if love.keyboard.isDown(KEY_LEFT) then space.xv = space.xv - speed end
  if love.keyboard.isDown(KEY_RIGHT) then space.xv = space.xv + speed end

  space.x = space.x + space.xv*dt
  space.y = space.y + space.yv*dt
--  if space.xv > 10 then space.xv = space.xv - drag*dt elseif space.xv < -10 then space.xv = space.xv + drag*dt else space.xv = 0 end
--  if space.yv > 10 then space.yv = space.yv - drag*dt elseif space.yv < -10 then space.yv = space.yv + drag*dt else space.yv = 0 end

  for i = 1, #space.stars do
    space.stars[i].x = space.stars[i].x - space.xv/space.stars[i].layer*dt
    space.stars[i].y = space.stars[i].y - space.yv/space.stars[i].layer*dt

    if space.stars[i].x > 321 then space.stars[i].x = -1 end
    if space.stars[i].x < -1 then space.stars[i].x = 319 end
    if space.stars[i].y > 181 then space.stars[i].y = -1 end
    if space.stars[i].y < -1 then space.stars[i].y = 179 end
  end
end
