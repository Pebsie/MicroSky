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
          randomseed = randomseed..string.byte(char)
        end

        love.math.setRandomSeed(randomseed)
        startGame(ui.inputStr)
      end
    end
end

function love.textinput(t)
    ui.inputStr = ui.inputStr .. t
end
