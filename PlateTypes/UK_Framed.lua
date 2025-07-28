-- UK Framed Plate
dofile('PlateTypes/_shared.lua')

plate.size = { 1024, 540 }
text.size = 120

drawPlateText = function(_, prefix, number, postfix)   -- Define the drawing function for this plate type
    drawTwoLineUKText(prefix, number, postfix)
end