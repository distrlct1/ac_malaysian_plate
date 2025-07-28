-- EV Plate
-- This script defines the properties for the Electric Vehicle (EV) license plate design.
dofile('PlateTypes/_shared.lua')

plate.size = { 1024, 256 }  -- Same as EU, adjust if EV plate differs

text.size = 140
text.font = 'FE-FONT.TTF'
text.color = '#000000'
text.kerning = 5
text.spaces = 48

drawPlateText = drawEVText