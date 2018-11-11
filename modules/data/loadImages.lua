function loadUI()
  uiImg = {}
  uiImg["logo"] = love.graphics.newImage("img/logo.png")
end

function loadRaces()
  raceImg = {}
  for i = 1, settings.races do
    raceImg[i] = {}
    raceImg[i].idle = love.graphics.newImage("img/creatures/"..i.."/idle.png")
    raceImg[i].gun = love.graphics.newImage("img/creatures/"..i.."/gun.png")
    raceImg[i].pistol = love.graphics.newImage("img/creatures/"..i.."/pistol.png")
    raceImg[i].melee = love.graphics.newImage("img/creatures/"..i.."/melee.png")
  end

  raceImg["human"] = {}
  raceImg["human"].player = love.graphics.newImage("img/creatures/human/player.png")
  raceImg["human"].idle = love.graphics.newImage("img/creatures/human/idle.png")
  raceImg["human"].gun = love.graphics.newImage("img/creatures/human/gun.png")
  raceImg["human"].pistol = love.graphics.newImage("img/creatures/human/pistol.png")
  raceImg["human"].melee = love.graphics.newImage("img/creatures/human/melee.png")
end

function loadPlanets()
  planetImg = {}
  for i = 1, settings.planets do
    planetImg[i] = {}
    planetImg[i].image =  love.image.newImageData("img/planets/"..i..".png") -- imageData is used here to extract the center pixel for the planet surface
    planetImg[i].img = love.graphics.newImage(planetImg[i].image)
    planetImg[i].r, planetImg[i].g, planetImg[i].b = planetImg[i].image:getPixel(planetImg[i].img:getWidth()/2,planetImg[i].img:getHeight()/2) -- get the center pixel
  end
end

function loadVehicles()
  vehicleImg = {}

  vehicleImg["ship1"] = love.graphics.newImage("img/vehicles/ship1.png")
end

function loadSurface()
  surfaceImg = {}
  surfaceImg["ground"] = love.graphics.newImage("img/surface/ground.png")
  surfaceImg["house"] = love.graphics.newImage("img/surface/house.png")
end
