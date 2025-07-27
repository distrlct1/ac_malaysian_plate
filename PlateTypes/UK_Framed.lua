-- UK Framed Plate
-- This script defines the properties for the UK framed license plate design.
dofile('PlateTypes/_shared.lua')

plate.size = { 1024, 540 }  -- Set the size of the plate
text.size = 120  -- Set the text size

drawPlateText = function(_, prefix, number, postfix)   -- Define the drawing function for this plate type
    drawTwoLineUKText(prefix, number, postfix)
end
