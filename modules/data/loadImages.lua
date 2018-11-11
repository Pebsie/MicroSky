function loadUI()
  uiImg = {}
  uiImg["logo"] = love.graphics.newImage("img/logo.png")
  uiImg["hp"] = love.graphics.newImage("img/ui/hp.png")
  uiImg["res"] = love.graphics.newImage("img/ui/res.png")
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

function loadUnits()
  unitImg = {}
  unitImg["flag"] = love.graphics.newImage("img/surface/flag.png")
  unitImg["scientist"] = love.graphics.newImage("img/surface/scientist.png")
  unitImg["miner"] = love.graphics.newImage("img/surface/miner.png")
  unitImg["turret"] = love.graphics.newImage("img/surface/turret.png")
end

function loadPlanets()
  planetImg = {}
  for i = 1, settings.planets do
    planetImg[i] = {}
    planetImg[i].image =  love.image.newImageData("img/planets/"..i..".png") -- imageData is used here to extract the center pixel for the planet surface
    planetImg[i].img = love.graphics.newImage(planetImg[i].image)
    planetImg[i].r, planetImg[i].g, planetImg[i].b = planetImg[i].image:getPixel(planetImg[i].img:getWidth()/2,planetImg[i].img:getHeight()/2) -- get the center pixel
  end

  planetImg["asteroid"] = {}
  planetImg["asteroid"].img = love.graphics.newImage("img/planets/asteroid.png")
end

function loadVehicles()
  vehicleImg = {}

  vehicleImg["ship1"] = love.graphics.newImage("img/vehicles/ship1.png")
end

function loadSurface()
  surfaceImg = {}
  surfaceImg["ground"] = love.graphics.newImage("img/surface/ground.png")
  surfaceImg["house"] = love.graphics.newImage("img/surface/house.png")
  surfaceImg["rock"] = love.graphics.newImage("img/surface/rock.png")
end
