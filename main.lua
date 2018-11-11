require("modules/import")

phase = "menu"

love.graphics.setDefaultFilter( "nearest", "nearest", 1 )

function love.load()
  love.keyboard.setTextInput(true)
  loadRaces()
  loadPlanets()
  loadVehicles()
  love.graphics.setLineWidth(0.2)
end

function love.draw()
  love.graphics.push()
  love.graphics.scale(love.graphics.getWidth()/320, love.graphics.getHeight()/180)

  if phase == "menu" then drawMenu()
  elseif phase == "space" then drawSpace() end

   love.graphics.pop()
end

function love.update(dt)
  if phase == "space" then updateSpace(dt) end
end
