-- Malaysian license plate generator for Assetto Corsa

-- Plate dimensions and appearance
plate.size = { 1024, 540 }
plate.background = 'malaysia_bg.png'
plate.normals = 'malaysia_nm.png'
plate.light = -90

-- Text properties (default font for standard plates)
text.font = 'arialbold.ttf'
text.size = 250
text.color = '#FFFFFF'
text.weight = FontWeight.Normal
text.kerning = -4
text.spaces = 48

-- Input parameters
defineSelect('PlateType', {'Standard', 'Special', 'Custom'}, 'Standard')
defineText('Prefix', 3, InputLength.Varying, nil)
defineNumber('Number', 4, 1, 9999, nil)
defineText('Postfix', 1, InputLength.Varying, nil)

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
    { prefix = prefixChars.PeninsularMalaysia, body = extraLetterChars.Default, postfix = nil, extraLetters = 2 },  -- Peninsular Malaysia
    { prefix = prefixChars.KualaLumpurNew, body = extraLetterChars.Default, postfix = nil, extraLetters = 2 },  -- Kuala Lumpur New
    { prefix = prefixChars.KualaLumpurOld, body = extraLetterChars.Default, postfix = postfixChars.Default, extraLetters = 2 },  -- Kuala Lumpur Old
    { prefix = prefixChars.Langkawi, body = nil, postfix = postfixChars.Default, extraLetters = 0 },  -- Langkawi
    { prefix = prefixChars.Putrajaya, body = extraLetterChars.Putrajaya, postfix = nil, extraLetters = 1 },  -- Putrajaya
    { prefix = "Q", division = stateDivisionChars.Sarawak, body = extraLetterChars.Default, postfix = postfixChars.Sarawak, extraLetters = 1 },  -- Sarawak
    { prefix = "S", division = stateDivisionChars.Sabah, body = extraLetterChars.Default, postfix = postfixChars.Sabah, extraLetters = 1 },  -- Sabah
    { prefix = "L", body = extraLetterChars.Default, postfix = nil, extraLetters = 1 },  -- Labuan
}

local specialPrefixes = {
    { prefix = {"PROTON", "PERODUA", "WAJA", "Chancellor", "Putra", "Persona", "Satria", "Tiara", "Perdana", "LOTUS", "KRISS", "Jaguh", "NAZA", "SUKOM", "BAMbee", "XIIINAM", "XOIC", "XXVIASEAN", "XXXIDB", "1M4U", "PATRIOT", "PERFECT", "TTB", "NAAM", "VIP", "RIMAU", "IQ", "FFF", "GT", "GTR", "G1M", "GOLD", "GP", "A1M", "T1M", "K1M", "NBOS", "Q", "QQ", "SAS", "SAM", "SMS", "E", "X", "XX", "Y", "YY", "YA", "YC", "U", "UU", "UUU", "US", "UP", "UA", "UT", "UMT", "UM", "UNIMAS", "UNISZA", "UTM", "UTEM", "UKM", "UUM", "USM", "UiTM", "UPM", "UTHM", "IIUM", "UMK", "UR", "UC", "UG", "UN", "UQ", "AAA", "BBB", "JJJ", "CCC", "WWW", "RR", "DDD", "PPP", "FF", "F1", "W1N", "BMW", "RM", "AKU", "SYG", "KFC", "MCM", "JPJ"}, font = nil, postfix = nil },  -- General
    { prefix = {"Malaysia", "Putrajaya"}, font = "calistomtitalic.ttf", postfix = nil },  -- Special Font
    { prefix = "G", font = nil, postfix = "G" },  -- Specific Suffix
    { prefix = "M", font = nil, postfix = "M" },  -- Specific Suffix
    { prefix = "WWW", font = nil, postfix = 1 },  -- Specific Suffix
    { prefix = "JJJ", font = nil, postfix = 1 },  -- Specific Suffix
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
    -- Reset font every time to avoid carryover
    text.font = "arialbold.ttf"

    local plateText = ""
    
    if plateType == "Custom" then
        -- Generate custom plate based on user input
        plateText = prefix or ""
        if number then
            if plateText ~= "" then plateText = plateText .. " " end
            plateText = plateText .. formatNumber(number)
        end
        if postfix and postfix ~= "" then
            if plateText ~= "" then plateText = plateText .. " " end
            plateText = plateText .. postfix
        end
    elseif plateType == "Standard" then
        -- Randomly select a state prefix configuration
        local stateConfig = statePrefixes[math.random(#statePrefixes)]
        
        -- Generate the state prefix
        local prefix = type(stateConfig.prefix) == "table" and getRandomElement(stateConfig.prefix) or stateConfig.prefix
        plateText = prefix
        
        -- Add division character if applicable, otherwise add random body characters
        if stateConfig.division then
            plateText = plateText .. getRandomElement(stateConfig.division)
            plateText = plateText .. getRandomElement(stateConfig.body)
        else
            for i = 1, stateConfig.extraLetters do
                plateText = plateText .. getRandomElement(stateConfig.body or {})
            end
        end
        
        -- Add space and random number without leading zeros
        plateText = plateText .. " " .. formatNumber(math.random(1, 9999))
        
        -- Add postfix if applicable
        if stateConfig.postfix then
            plateText = plateText .. " " .. getRandomElement(stateConfig.postfix)
        end
    elseif plateType == "Special" then
        -- Randomly select a special prefix configuration
        local specialConfig = specialPrefixes[math.random(#specialPrefixes)]
        
        -- Generate the special prefix
        local prefix = type(specialConfig.prefix) == "table" and getRandomElement(specialConfig.prefix) or specialConfig.prefix
        plateText = prefix
        
        -- Add space and random number without leading zeros
        plateText = plateText .. " " .. formatNumber(math.random(1, 9999))
        
        -- Add postfix if applicable
        if specialConfig.postfix then
            if type(specialConfig.postfix) == "number" then
                plateText = plateText .. " " .. string.char(64 + math.random(26))
            else
                plateText = plateText .. " " .. specialConfig.postfix
            end
        end
        
        -- Set special font if applicable
        if specialConfig.font then
            text.font = specialConfig.font
        end
    end

    -- Ensure plateText is not empty
    if plateText == "" then
        plateText = "Invalid Plate"
    end

    -- Split the plate text into prefix and number-postfix
    local prefixText = ""
    local numberPostfixText = ""
    for word in plateText:gmatch("%S+") do
        if prefixText == "" then
            prefixText = word
        else
            numberPostfixText = numberPostfixText .. " " .. word
        end
    end
    numberPostfixText = numberPostfixText:sub(2)

    -- Draw the plate text
    drawText(prefixText, 0, -110, Gravity.Center)
    drawText(numberPostfixText, 0, 110, Gravity.Center)
end