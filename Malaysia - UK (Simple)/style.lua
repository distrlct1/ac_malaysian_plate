--[[
Very simple style, made for Morgan 3 Wheeler. With this system, it’s much easier
to quickly create a new style instead of loading Photoshop.
]]

-- input params:
defineText('Top Line', 4, InputLength.Fixed, nil)
defineText('Bottom Line', 3, InputLength.Fixed, nil)

return function(topLine, bottomLine)
  -- number plate params
  plate.size = { 512, 392 }
  plate.background = 'malaysia_bg.png'
  plate.normals = 'malaysia_nm.png'
  plate.light = -90  -- set to 203 to match Kunos textures with diagonal lighting
  
  -- text params
  text.font = 'arialbd.ttf'
  text.color = '#FFFFFF'
  text.size = 210
  text.weight = FontWeight.Normal
  text.lineSpacing = 49
  text.kerning = -8
  
  -- draw text
  drawText(topLine .. '\n' .. bottomLine, 0, 0, Gravity.Center)
end