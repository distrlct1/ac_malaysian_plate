-- EU Framed Plate
-- This script defines the properties for the EU framed license plate design.
dofile('PlateTypes/_shared.lua')

plate.size = { 1024, 256 }  -- Set the size of the plate
text.size = 150  -- Set the text size

drawPlateText = drawCenteredText  -- Define the drawing function for this plate type
