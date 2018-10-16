gjeresia = 600
gjatesia = 600

_r, _g, _b, _a = 255, 255, 255, 1

-- Te dhenat e lojes

-- Harta e lojes
--  . -> hapesire boshe
--  # -> mur

harta = {
    "#","#","#","#","#","#","#","#","#","#","#","#","#","#","#","#","#","#","#","#",
    "#",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".","#",
    "#",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".","#",
    "#",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".","#",
    "#",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".","#",
    "#",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".","#",
    "#",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".","#",
    "#",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".","#",
    "#",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".","#",
    "#",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".","#",
    "#",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".","#",
    "#",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".","#",
    "#",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".","#",
    "#",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".","#",
    "#",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".","#",
    "#",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".","#",
    "#",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".","#",
    "#",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".","#",
    "#",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".","#",
    "#","#","#","#","#","#","#","#","#","#","#","#","#","#","#","#","#","#","#","#"
}

harta.rreshta = 20
harta.kolona = 20

function harta:me_koordinata(x, y)
    local x = math.floor(x)
    local y = math.floor(y)
    
    return harta[(x - 1) * harta.rreshta + y]
end

function harta:ne_ekran(x, y)
    local x = math.floor(x)
    local y = math.floor(y)

    return unpack({
        (x - 1) * kutia_gjeresia + zhvendosja_x,
        (y - 1) * kutia_gjatesia + zhvendosja_y
    })
end


-- Ky eshte objekti i gjarprit, ku do te ruhen te dhenat e tij
gjarpri = {}
gjarpri.shpejtesia = 4
gjarpri.drejtimi = "djathtas"
gjarpri.drejtimi_kaluar = ""
gjarpri.ngordhur = false
gjarpri.trupi = {
    {x = 5.0, y = 5.0},
    {x = 5.0, y = 5.0},
    {x = 5.0, y = 5.0},
    {x = 5.0, y = 5.0}
}

function gjarpri:shto_segment()
    segmente = #gjarpri.trupi

    gjarpri.trupi[segmente + 1].x = gjarpri.trupi[segmente].x
    gjarpri.trupi[segmente + 1].y = gjarpri.trupi[segmente].y
end

-- Tabela/objekti i molles
molla = {
    x = 2,
    y = 2
}

-- Ketu behet konfigurimi i lojes
function love.load()
    --Caktojme permasat e dritares
    love.window.setMode(gjeresia, gjatesia, {})

    --Caktojme nje sfond te bardhe (255 Red, 255 Green, 255 Blue)
    love.graphics.setBackgroundColor(255, 255, 255)

    --Fusim faren e random
    math.randomseed( os.time() )
end

-- Ketu eshte cikli i lojes, ku kryet e gjithe logjika.
function love.update(dt) 
    if gjarpri.ngordhur then
        return
    end
    
    --Merr inputin 

    gjarpri.drejtimi_kaluar = gjarpri.drejtimi

    if love.keyboard.isDown("up") and gjarpri.drejtimi_kaluar~="poshte" then
        gjarpri.drejtimi = "lart"
    elseif love.keyboard.isDown("right") and gjarpri.drejtimi_kaluar~="majtas" then
        gjarpri.drejtimi = "djathtas"
    elseif love.keyboard.isDown("down") and gjarpri.drejtimi_kaluar~="lart" then
        gjarpri.drejtimi = "poshte"
    elseif love.keyboard.isDown("left") and gjarpri.drejtimi_kaluar~="djathtas" then
        gjarpri.drejtimi = "majtas"
    end

    --Leviz gjarprin
    --
    --Leviz koken, dhe bej qe pjeset e tjera te ndjekin njera-tjetren
    --

    if not gjarpri.drejtimi == gjarpri.dretimi_kaluar then
        gjarpri.trupi[1].x = math.floor(gjarpri.trupi[1].x)
        gjarpri.trupi[1].y = math.floor(gjarpri.trupi[1].y) 
    end

    levizja = gjarpri.shpejtesia * dt

    x_ri = gjarpri.trupi[1].x
    y_ri = gjarpri.trupi[1].y

    if gjarpri.drejtimi == "lart" then
        y_ri = y_ri - levizja
    elseif gjarpri.drejtimi == "djathtas" then
        x_ri = x_ri + levizja  
    elseif gjarpri.drejtimi == "poshte" then
        y_ri = y_ri + levizja
    elseif gjarpri.drejtimi == "majtas" then
        x_ri = x_ri - levizja
    end 

    kutia = harta:me_koordinata(x_ri, y_ri)

    if kutia == "#" then
        gjarpri.ngordhur = true
        return 
    end

    --Keput bishtin dhe dyfisho koken. Ne kete menyre imitohet levizja
    if math.floor(x_ri) ~= math.floor(gjarpri.trupi[1].x)
        or math.floor(y_ri) ~= math.floor(gjarpri.trupi[1].y) then
        
        table.remove(gjarpri.trupi, #gjarpri.trupi)
        table.insert(gjarpri.trupi, 2, {})
         
        gjarpri.trupi[2].x = gjarpri.trupi[1].x
        gjarpri.trupi[2].y = gjarpri.trupi[1].y

    end

    --Tani leviz koken
    --
    gjarpri.trupi[1].x = x_ri
    gjarpri.trupi[1].y = y_ri 

end

-- Ketu behet vizatimi i lojes
zhvendosja_x = 0
zhvendosja_y = 0

kutia_gjeresia = (gjeresia - zhvendosja_x) / harta.kolona
kutia_gjatesia = (gjatesia - zhvendosja_y) / harta.rreshta

function love.draw()
    -- Vizatojme harten
    for _x=1,harta.rreshta do
        for _y=1,harta.kolona do 
            -- Merr vleren e kutise perkatese ne harte
            kutia = harta:me_koordinata(_x, _y)
          
            -- Gjej kooridnaten ne ekran
            local x, y = harta:ne_ekran(_x, _y)

            if kutia == "#" then
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("fill", x, y,kutia_gjeresia, kutia_gjatesia)
            elseif kutia == "." then
                love.graphics.setColor(100, 100, 100)
                love.graphics.rectangle("fill", x, y,kutia_gjeresia, kutia_gjatesia)
            end

            love.graphics.setColor(_r, _g, _b, _a)
        end
    end

    -- Vizatojme mollen
        
    local x, y = harta:ne_ekran(molla.x, molla.y)

    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", x, y, kutia_gjeresia, kutia_gjatesia)
    love.graphics.setColor(_r, _g, _b, _a)

    --Vizatojme gjarprin
    for i,segment in ipairs(gjarpri.trupi) do
        love.graphics.setColor(100, 200, 0, 1)

        --Kthejme koordinatat ne harte , ne koordinata ne ekran

        local x, y = harta:ne_ekran(segment.x, segment.y)

        love.graphics.rectangle("fill", x, y, kutia_gjeresia, kutia_gjatesia) 

        love.graphics.setColor(_r, _g, _b, _a)
    end
end
