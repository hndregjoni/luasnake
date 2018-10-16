gjeresia = 800
gjatesia = 800

-- Ketu behet konfigurimi i lojes
function love.load()
    --Caktojme permasat e dritares
    love.window.setMode(gjeresia, gjatesia, {})

    --Caktojme nje sfond te bardhe (255 Red, 255 Green, 255 Blue)
    love.graphics.setBackgroundColor(255, 255, 255)
end

-- Ketu behet vizatimi i lojes
function love.draw()
    love.graphics.print("Hello World!", 400, 300)
end
