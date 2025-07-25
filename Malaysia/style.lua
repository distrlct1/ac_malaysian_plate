-- Scan for available backgrounds and normal maps
local function scanForPlates(directory)
    local plates = {}
    for i, file in ipairs(fs.readDir(directory, '*.png')) do
        if not file:find('_nm.png') then
            local name = path.getFileNameWithoutExtension(file)
            plates[name] = name
        end
    end
    return plates
end

-- Input Parameters
defineSelect('PlateType', {'UK', 'EU', 'EV'}, 'UK') -- Dropdown for Plate Type
defineSelect('FrameStyle', {'Simple', 'Framed'}, 'Simple') -- Dropdown for Frame Style
defineSelect('PlateGeneration', {'Random', 'Standard', 'Special', 'Custom'}, 'Standard') -- Dropdown for Plate Generation

-- Dynamic Inputs
defineNumber('PlateNumber', 4, 1, 9999, nil) -- Slider for number selection (shown for Random/Standard/Special)
defineText('CustomPrefix', 3, InputLength.Varying, nil) -- Text input for Custom Prefix (shown for Custom)
defineText('CustomPostfix', 1, InputLength.Varying, nil) -- Text input for Custom Postfix (shown for Custom)

-- Logic to show/hide inputs based on Plate Generation selection
function updateInputs()
    local generationType = getValue('PlateGeneration')

    if generationType == "Custom" then
        -- Show custom prefix and postfix inputs
        showInput('CustomPrefix', true)
        showInput('CustomPostfix', true)
        showInput('PlateNumber', false) -- Hide number slider
    else
        -- Hide custom inputs
        showInput('CustomPrefix', false)
        showInput('CustomPostfix', false)
        showInput('PlateNumber', true) -- Show number slider
    end
end

-- Call updateInputs whenever the Plate Generation dropdown changes
onChange('PlateGeneration', updateInputs)

-- Initial call to set the correct visibility of inputs
updateInputs()

-- Configure Plate Appearance
function configurePlateAppearance(frameStyle, plateType)
    local plateConfig = {}
    
    if plateType == "UK" then
        if frameStyle == "Framed" then
            plateConfig.size = { 1024, 540 }
            plateConfig.textSize = 250
            plateConfig.textYOffset = 110 -- For double line
            plateConfig.background = "uk_framed_bg.png"
            plateConfig.normals = "uk_framed_nm.png"
        else -- Simple
            plateConfig.size = { 512, 396 }
            plateConfig.textSize = 140
            plateConfig.textYOffset = 60 -- For double line
            plateConfig.background = "uk_simple_bg.png"
            plateConfig.normals = "uk_simple_nm.png"
        end
    elseif plateType == "EU" then
        if frameStyle == "Framed" then
            plateConfig.size = { 1024, 256 }
            plateConfig.textSize = 150
            plateConfig.textYOffset = 0 -- Centered for single line
            plateConfig.background = "eu_framed_bg.png"
            plateConfig.normals = "eu_framed_nm.png"
        else -- Simple
            plateConfig.size = { 1024, 256 }
            plateConfig.textSize = 180
            plateConfig.textYOffset = 0 -- Centered for single line
            plateConfig.background = "eu_simple_bg.png"
            plateConfig.normals = "eu_simple_nm.png"
        end
    end
    
    plateConfig.light = -90
    plateConfig.font = "arialbold.ttf"
    plateConfig.color = "#FFFFFF"
    plateConfig.kerning = -4
    plateConfig.spaces = 48
    
    return plateConfig
endend

-- Prefixes Data
local prefixChars = {
    PeninsularMalaysia = {'A', 'B', 'C', 'D', 'J', 'K', 'M', 'N', 'P', 'R', 'T'},
    KualaLumpurNew = {'V'},
    KualaLumpurOld = {'W'},
    Langkawi = {'KV'},
    Putrajaya = {'F'},
}

local postfixChars = {
    Default = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'},
    Sarawak = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y'},
    Sabah = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'R', 'T', 'U', 'V', 'W', 'X', 'Y'},
}

local extraLetterChars = {
    Default = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y'},
    Putrajaya = {'A', 'B', 'C'},
}

local stateDivisionChars = {
    Sarawak = {'A', 'B', 'C', 'D', 'K', 'M', 'Q', 'R', 'T'},
    Sabah = {'A', 'B', 'D', 'E', 'K', 'M', 'S', 'T', 'U'},
}

-- State Prefixes
local statePrefixes = {
    { prefix = prefixChars.PeninsularMalaysia, body = extraLetterChars.Default, postfix = nil, extraLetters = 2 },
    { prefix = prefixChars.KualaLumpurNew, body = extraLetterChars.Default, postfix = nil, extraLetters = 2 },
    { prefix = prefixChars.KualaLumpurOld, body = extraLetterChars.Default, postfix = postfixChars.Default, extraLetters = 2 },
    { prefix = prefixChars.Langkawi, body = nil, postfix = postfixChars.Default, extraLetters = 0 },
    { prefix = prefixChars.Putrajaya, body = extraLetterChars.Putrajaya, postfix = nil, extraLetters = 1 },
    { prefix = "Q", division = stateDivisionChars.Sarawak, body = extraLetterChars.Default, postfix = postfixChars.Sarawak, extraLetters = 1 },
    { prefix = "S", division = stateDivisionChars.Sabah, body = extraLetterChars.Default, postfix = postfixChars.Sabah, extraLetters = 1 },
    { prefix = "L", body = extraLetterChars.Default, postfix = nil, extraLetters = 1 },
}

local specialPrefixes = {
    { prefix = {"PROTON", "PERODUA", "WAJA", "Chancellor", "Putra", "Persona", "Satria", "Tiara", "Perdana", "LOTUS", "KRISS", "Jaguh", "NAZA", "SUKOM", "BAMbee", "XIIINAM", "XOIC", "XXVIASEAN", "XXXIDB", "1M4U", "PATRIOT", "PERFECT", "TTB", "NAAM", "VIP", "RIMAU", "IQ", "FFF", "GT", "GTR", "G1M", "GOLD", "GP", "A1M", "T1M", "K1M", "NBOS", "Q", "QQ", "SAS", "SAM", "SMS", "E", "X", "XX", "Y", "YY", "YA", "YC", "U", "UU", "UUU", "US", "UP", "UA", "UT", "UMT", "UM", "UNIMAS", "UNISZA", "UTM", "UTEM", "UKM", "UUM", "USM", "UiTM", "UPM", "UTHM", "IIUM", "UMK", "UR", "UC", "UG", "UN", "UQ", "AAA", "BBB", "JJJ", "CCC", "WWW", "RR", "DDD", "PPP", "FF", "F1", "W1N", "BMW", "RM", "AKU", "SYG", "KFC", "MCM", "JPJ"}, font = nil, postfix = nil },
    { prefix = {"Malaysia", "Putrajaya"}, font = "calistomtitalic.ttf", postfix = nil },
    { prefix = "G", font = nil, postfix = "G" },
    { prefix = "M", font = nil, postfix = "M" },
    { prefix = "WWW", font = nil, postfix = 1 },
    { prefix = "JJJ", font = nil, postfix = 1 },
}

-- Helper function to check if a value is in a table
local function isInTable(tbl, val)
    for _, v in ipairs(tbl) do
        if v == val then return true end
    end
    return false
end

-- Helper function to get a random element from a table
local function getRandomElement(tbl)
    return tbl[math.random(#tbl)]
end

-- Helper function to get the state prefix configuration
local function getStatePrefix(prefix)
    for _, config in ipairs(statePrefixes) do
        if type(config.prefix) == "table" then
            if isInTable(config.prefix, prefix) then return config end
        elseif config.prefix == prefix then
            return config
        end
    end
    return nil
end

-- Helper function to get the special prefix configuration
local function getSpecialPrefix(prefix)
    for _, config in ipairs(specialPrefixes) do
        if type(config.prefix) == "table" then
            if isInTable(config.prefix, prefix) then return config end
        elseif config.prefix == prefix then
            return config
        end
    end
    return nil
end

-- Helper function to format the number without leading zeros
local function formatNumber(num)
    return tostring(num):gsub("^0+", "")
end

-- Main function
return function(plateType, prefix, number, postfix)
    local frameStyle = getValue('FrameStyle')
    local config = configurePlateAppearance(frameStyle, plateType)

    -- Reset font every time to avoid carryover
    text.font = "arialbold.ttf"

    local plateText = ""

    if plateType == "Custom" then
        if plateType == "Custom" then
            plateText = (prefix or "") .. (number and " " .. formatNumber(number) or "") .. (postfix and " " .. postfix or "")
        end
    elseif plateType == "Standard" then
        local stateConfig = statePrefixes[math.random(#statePrefixes)]
        local prefix = type(stateConfig.prefix) == "table" and getRandomElement(stateConfig.prefix) or stateConfig.prefix
        plateText = prefix

        if stateConfig.division then
            plateText = plateText .. getRandomElement(stateConfig.division)
            plateText = plateText .. getRandomElement(stateConfig.body)
        else
            for i = 1, stateConfig.extraLetters do
                plateText = plateText .. getRandomElement(stateConfig.body or {})
            end
        end

        plateText = plateText .. " " .. formatNumber(math.random(1, 9999))

        if stateConfig.postfix then
            plateText = plateText .. " " .. getRandomElement(stateConfig.postfix)
        end
    elseif plateType == "Special" then
        local specialConfig = specialPrefixes[math.random(#specialPrefixes)]
        local selectedPrefix = type(specialConfig.prefix) == "table" and getRandomElement(specialConfig.prefix) or specialConfig.prefix
        plateText = selectedPrefix

        plateText = plateText .. " " .. formatNumber(math.random(1, 9999))

        if specialConfig.postfix then
            if type(specialConfig.postfix) == "number" then
                plateText = plateText .. " " .. string.char(64 + math.random(26))
            else
                plateText = plateText .. " " .. specialConfig.postfix
            end
        end

        if specialConfig.font then
            text.font = specialConfig.font
        end
    end

    if plateText == "" then
        plateText = "Invalid Plate"
    end

    if plateType == "UK" and frameStyle == "Framed" then
        local spacePos = plateText:find(" ")
        local prefixText = spacePos and plateText:sub(1, spacePos - 1) or plateText
        local numberPostfixText = spacePos and plateText:sub(spacePos + 1) or ""

        drawText(prefixText, 0, -config.textYOffset, Gravity.Center)
        drawText(numberPostfixText, 0, config.textYOffset, Gravity.Center)
    else
        drawText(plateText, 0, config.textYOffset, Gravity.Center)
    end
end
