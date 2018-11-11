space = { x = 2000, y = 2000, xv = 0, yv = 0 }
space.asteroids = {}

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
      drawMessageBox("Press <"..KEY_LAND.."> to land.",180-48)
      drawMessageBox("Home of the "..game.race[game.planet[i].race].name,180-32)
      love.graphics.draw(raceImg[game.race[game.planet[i].race].img].idle,0,180-48)
      love.graphics.draw(raceImg[game.race[game.planet[i].race].img].idle,320-32,180-48)
      drawMessageBox("You are "..getRepStr(game.race[game.planet[i].race].hostility).." by this race.",180-16)
      if love.keyboard.isDown(KEY_LINK) then
        for k = 1, game.planets do
          if game.planet[k].race == game.planet[i].race then
            love.graphics.line(game.planet[i].x+24-space.x,game.planet[i].y+24-space.y,game.planet[k].x+24-space.x,game.planet[k].y+24-space.y)
          end
        end
      end
    end

    if love.keyboard.isDown(KEY_SCAN) then
      if distanceFrom(game.planet[i].x+8, game.planet[i].y+8, space.x+150, space.y+80) < 600 then if game.planet[i].visited then love.graphics.setColor(0,0.6,0) elseif game.planet[i].img == 1 then love.graphics.setColor(0.5,0.5,0) else love.graphics.setColor(1,1,1) end love.graphics.line(game.planet[i].x-space.x+16, game.planet[i].y-space.y+16, 150+12, 80+12) nearestplan = 0
      elseif nearestplan < 1 then if distanceFrom(game.planet[i].x+8, game.planet[i].y+8, space.x+150, space.y+80) < nearestplan then nearestplan = distanceFrom(game.planet[i].x+8, game.planet[i].y+8, space.x+150, space.y+80) end end
    end
    love.graphics.setColor(1,1,1)
  end

  for i = 1, #space.asteroids do
    love.graphics.draw(planetImg["asteroid"].img, space.asteroids[i].x-space.x, space.asteroids[i].y-space.y)
  end

  if nearestplan > 1 and love.keyboard.isDown(KEY_SCAN) then
    drawMessageBox("Nearest planet: "..nearestplan.." units away",180-16)
  end

  if love.keyboard.isDown(KEY_HELP) then
  --  love.graphics.print("Use <"..KEY_UP..">, <"..KEY_LEFT..">, <"..KEY_DOWN.."> & <"..KEY_RIGHT.."> to navigate.\nPress <"..KEY_SCAN.."> to scan for planets.")
  else
  --  love.graphics.print("Hold <"..KEY_HELP.."> for help")
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

  if love.math.random(1, 200) == 1 then
    createAsteroid(#space.asteroids+1)
  end

  for i = 1, #space.asteroids do
    space.asteroids[i].x = space.asteroids[i].x + space.asteroids[i].xv*dt
    space.asteroids[i].y = space.asteroids[i].y + space.asteroids[i].yv*dt
    if distanceFrom(space.asteroids[i].x,space.asteroids[i].y,space.x+150, space.y+80) < 16 then
      player.hp = player.hp - (space.asteroids[i].atk / love.math.random(1, player.def))
      createAsteroid(i)
    end
  end
end

function createAsteroid(i)
  space.asteroids[i] = {x = love.math.random(1,4000),y = love.math.random(1,4000), xv = love.math.random(-200,200), yv = love.math.random(-200,200), atk = love.math.random(1,4)}
end

function getRepStr(i)
  if i > 20 then return "considered a monster"
  elseif i > 15 then return "hated"
  elseif i > 5 then return "disliked"
  elseif i > 0 then return "thought poorly of"
  elseif i > -5 then return "thought well of"
  elseif i > -10 then return "liked"
  elseif i > -20 then return "worshipped as a god"
  else return "never thought of" end
end
