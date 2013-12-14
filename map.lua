Map = class("Map")


function Map:initialize()

    self.name        = "No map loaded"
    self.description = "uhm wat"
    self.mapdata     = {}
    self.paths       = {}

end

function Map:draw()

    love.graphics.setColor(255, 255, 255)

    for y, row in ipairs(self.mapdata) do
        for x, tile in ipairs(row) do
    
            tile:draw()
    
        end
    end

end

function Map:loadFile(name)

    local filedata = love.filesystem.read(name)
    local mapobj = json.decode(filedata)

    self.name        = mapobj.name or "- none -"
    self.description = mapobj.description or "- none -"


    self.mapdata = {}
    for y, row in ipairs(mapobj.mapdata) do

        local targetRow = {}

        for x, tile in ipairs(row) do

            table.insert(targetRow, Tile:new(tile, Tile.SIZE * (x - 1), Tile.SIZE * (y - 1)))

        end

        table.insert(self.mapdata, targetRow)

    end


    self.paths = {}
    for i, path in ipairs(mapobj.mapdata) do

        table.insert(self.paths, path)

    end

end
