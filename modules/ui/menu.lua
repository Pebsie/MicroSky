menu = {r = 0, g = 0, b = 0}

function drawMenu()
  love.graphics.setColor(menu.r,menu.g,menu.b)
    love.graphics.draw(uiImg["logo"],320/2-uiImg["logo"]:getWidth()/2,0)
    love.graphics.setColor(1,1,1)
    love.graphics.print("Randomseed: "..ui.inputStr.."\n\nPress <enter> to begin.",0,100)
end

function updateMenu(dt)
  menu.r = menu.r + (love.math.random(1,20)/100) * dt
  menu.g = menu.g + (love.math.random(1,40)/100) * dt
  menu.b = menu.b + (love.math.random(1,20)/100) * dt
end
