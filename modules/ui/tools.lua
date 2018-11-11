function drawMessageBox(text,y)
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill",0,y,320,16)
  love.graphics.setColor(1,1,1)
  love.graphics.printf(text,0,y,320,"center")
end
