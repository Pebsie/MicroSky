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
      if key == KEY_LAND and surface.x == surface.shipx and surface.y == surface.shipy and surface.zoneX == surface.shipZX and surface.zoneY == surface.shipZY then phase = "space"
      elseif key == KEY_LAND and surface.sel == false then surface.selX = surface.x surface.selY = surface.y surface.sel = true
      elseif key == KEY_LAND and surface.sel == true then
        if game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.selX][surface.selY].unit == "miner" and not game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.selX][surface.selY].unitCount then
          local t = game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.x][surface.y].type
          if t == "rock" then
            game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.selX][surface.selY].unitCount = 1
            addAction("mine",surface.zoneX,surface.zoneY,surface.selX,surface.selY,surface.x,surface.y,surface.planet)

            surface.sel = false
          end
        elseif game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.selX][surface.selY].unit == "turret" and not game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.selX][surface.selY].unitCount then
            game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.selX][surface.selY].unitCount = 1
            addAction("attack",surface.zoneX,surface.zoneY,surface.selX,surface.selY,surface.x,surface.y,surface.planet)
            surface.sel = false
        end

        surface.sel = false
      end
      if key == KEY_SCAN and player.res > 0 and not game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.x][surface.y].unit then
        game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.x][surface.y].unit = "flag"
      elseif key == "1" and getUnit() == "flag" and player.res > 0 then
        game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.x][surface.y].unit = "miner"
        player.res = player.res - 1
      elseif key == "2" and getUnit() == "flag" and player.res > 2 then
        game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.x][surface.y].unit = "research"
        player.res = player.res - 3
      elseif key == "3" and getUnit() == "flag" and player.res > 9 then
        game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.x][surface.y].unit = "barracks"
        player.res = player.res - 10
      elseif key == "4" and getUnit() == "flag" and player.res > 19 then
        game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.x][surface.y].unit = "turret"
        player.res = player.res - 20
      elseif key == KEY_SCAN and getUnit() == "miner" and game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.x][surface.y].unitCount then
        player.res = player.res + game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.x][surface.y].unitCount
        game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.x][surface.y].unitCount = 0
      end
    end
end

function love.textinput(t)
    ui.inputStr = ui.inputStr .. t
end
