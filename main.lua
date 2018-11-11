require("modules/import")

phase = "menu"

love.graphics.setDefaultFilter( "nearest", "nearest", 1 )

player = {hp = 10, res = 300, rep = 0, def = 1, nextMove = 0.5}

function love.load()
  love.keyboard.setTextInput(true)
  loadRaces()
  loadPlanets()
  loadVehicles()
  loadSurface()
  loadUI()
  loadUnits()
  love.graphics.setLineWidth(0.2)

  font = love.graphics.newFont(16)
  sFont = love.graphics.newFont(12)
  tFont = love.graphics.newFont(8)
end

function love.draw()
  love.graphics.push()
  love.graphics.scale(love.graphics.getWidth()/320, love.graphics.getHeight()/180)

  if phase == "menu" then drawMenu()
  elseif phase == "space" then drawSpace()
  elseif phase == "surface" then drawSurface() end

  if phase ~= "menu" then
    love.graphics.setFont(sFont)
    love.graphics.draw(uiImg["hp"])
    love.graphics.draw(uiImg["res"],uiImg["hp"]:getWidth()+sFont:getWidth(player.hp)+2)
    love.graphics.print(player.hp,uiImg["hp"]:getWidth())
    love.graphics.print(player.res,uiImg["hp"]:getWidth()+sFont:getWidth(player.hp)+2+uiImg["res"]:getWidth())
    love.graphics.setFont(font)
  end
   love.graphics.pop()
end

function love.update(dt)
  if phase == "menu" then updateMenu(dt) end
  if phase == "space" then updateSpace(dt) end
  if phase == "surface" then updateSurface(dt) end
  if phase == "space" or phase == "surface" then
    for i = 1, game.planets do
      updatePlanet(dt,i)
    end
  end
end
