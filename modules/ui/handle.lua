ui = {}
ui.inputStr = ""
local utf8 = require("utf8")

function love.keypressed( key, scancode, isrepeat )
    if key == "backspace" then
        -- get the byte offset to the last UTF-8 character in the string.
        local byteoffset = utf8.offset(ui.inputStr, -1)

        if byteoffset then
            -- remove the last UTF-8 character.
            -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
            ui.inputStr = string.sub(ui.inputStr, 1, byteoffset - 1)
        end
    end

    if phase == "menu" then
      if key == "return" then
        randomseed = 0
        for char in ui.inputStr:gmatch(".") do
          randomseed = randomseed + string.byte(char)
        end

        love.math.setRandomSeed(randomseed)
        startGame(ui.inputStr)
      end
    elseif phase == "space" then
      for i = 1, game.planets do
        if distanceFrom(game.planet[i].x+8, game.planet[i].y+8, space.x+150, space.y+80) < 16 then
          if love.keyboard.isDown(KEY_LAND) then
            enterPlanet(i)
          end
        end
      end
    elseif phase == "surface" then
      if key == KEY_UP then surface.y = surface.y - 1 end
      if key == KEY_DOWN then surface.y = surface.y + 1 end
      if key == KEY_LEFT then surface.x = surface.x - 1 end
      if key == KEY_RIGHT then surface.x = surface.x + 1 end
      if key == KEY_LAND and surface.x == surface.shipx and surface.y == surface.shipy then phase = "space" end
      if surface.x > 13 then
        surface.x = 1
        surface.zoneX = surface.zoneX + 1
      elseif surface.x < 1 then
        surface.x = 13
        surface.zoneX = surface.zoneX - 1
      elseif surface.y > 6 then
        surface.y = 1
        surface.zoneY = surface.zoneY + 1
      elseif surface.y < 1 then
        surface.y = 6
        surface.zoneY = surface.zoneY - 1
      end

      if not game.planet[surface.planet].zone[surface.zoneX] then game.planet[surface.planet].zone[surface.zoneX] = {} end
      if not game.planet[surface.planet].zone[surface.zoneX][surface.zoneY] then
        game.planet[surface.planet].zone[surface.zoneX][surface.zoneY] = generateZone(surface.planet)
      end
      uncoverFog()
    end
end

function love.textinput(t)
    ui.inputStr = ui.inputStr .. t
end
