-- Malaysian License Plate Generator for Assetto Corsa
-- This script generates Malaysian license plates based on selected designs and user inputs.
-- It supports various plate types and configurations, including standard, special, and custom plates.

-- Gather available plate designs from the PlateTypes folder
local plateDesigns = {}
for _, file in ipairs(fs.readDir('PlateTypes', '*.png')) do
    -- Exclude normal map files
    if not file:find('_nm.png') then
        -- Extract the name of the plate design
        local name = path.getFileNameWithoutExtension(file):gsub('_bg', '')
        plateDesigns[name] = name
    end
end

-- UI Inputs: Define selectable options for the user interface
defineSelect('PlateDesign', plateDesigns, 'EU_Framed')  -- Select plate design
defineSelect('plateType', {'Standard', 'Special', 'Custom'}, 'Standard')  -- Select plate type
defineText('Prefix', 3, InputLength.Varying, nil)  -- Input for prefix
defineNumber('Number', 4, 0, 9999, nil)  -- Input for number
defineText('Postfix', 1, InputLength.Varying, nil)  -- Input for postfix

-- Data tables for prefix, postfix, and extra letter characters
local prefixChars = {
    PeninsularMalaysia = {'A', 'B', 'C', 'D', 'J', 'K', 'M', 'N', 'P', 'R', 'T'},
    KualaLumpurNew = {'V'},
    KualaLumpurOld = {'W'},
    Langkawi = {'KV'},
    Putrajaya = {'F'},
}

local postfixChars = {
    Default = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'},
    Sarawak = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y'},
    Sabah = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','R','T','U','V','W','X','Y'},
}

local extraLetterChars = {
    Default = {'A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y'},
    Putrajaya = {'A','B','C'},
}

local stateDivisionChars = {
    Sarawak = {'A','B','C','D','K','M','Q','R','T'},
    Sabah = {'A','B','D','E','K','M','S','T','U'},
}

-- Configuration for state prefixes
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

-- Configuration for special prefixes
local specialPrefixes = {
    { prefix = {"PROTON","PERODUA","WAJA","Chancellor","Putra","Persona","Satria","Tiara","Perdana","LOTUS","KRISS","Jaguh","NAZA","SUKOM","BAMbee","XIIINAM","XOIC","XXVIASEAN","XXXIDB","1M4U","PATRIOT","PERFECT","TTB","NAAM","VIP","RIMAU","IQ","FFF","GT","GTR","G1M","GOLD","GP","A1M","T1M","K1M","NBOS","Q","QQ","SAS","SAM","SMS","E","X","XX","Y","YY","YA","YC","U","UU","UUU","US","UP","UA","UT","UMT","UM","UNIMAS","UNISZA","UTM","UTEM","UKM","UUM","USM","UiTM","UPM","UTHM","IIUM","UMK","UR","UC","UG","UN","UQ","AAA","BBB","JJJ","CCC","WWW","RR","DDD","PPP","FF","F1","W1N","BMW","RM","AKU","SYG","KFC","MCM","JPJ"} },
    { prefix = {"Malaysia", "Putrajaya"}, font = "calistomtitalic.ttf" },
    { prefix = "G", postfix = "G" },
    { prefix = "M", postfix = "M" },
    { prefix = "WWW", postfix = 1 },
    { prefix = "JJJ", postfix = 1 },
}

-- Utility functions
-- Check if a value exists in a table
local function isInTable(tbl, val)
    for _, v in ipairs(tbl or {}) do
        if v == val then return true end
    end
    return false
end

-- Get a random element from a table
local function getRandomElement(tbl)
    return tbl[math.random(#tbl)]
end

-- Find the configuration for a given prefix
local function findPrefixConfig(configs, prefix)
    for _, config in ipairs(configs) do
        if type(config.prefix) == "table" then
            if isInTable(config.prefix, prefix) then return config end
        elseif config.prefix == prefix then
            return config
        end
    end
    return nil
end

-- Generate the prefix string based on the state configuration
local function generatePrefixString(stateConfig)
    local prefixOut = type(stateConfig.prefix) == "table" and getRandomElement(stateConfig.prefix) or stateConfig.prefix
    if stateConfig.division then
        prefixOut = prefixOut .. getRandomElement(stateConfig.division) .. getRandomElement(stateConfig.body)
    else
        for i = 1, stateConfig.extraLetters do
            prefixOut = prefixOut .. getRandomElement(stateConfig.body or {})
        end
    end
    return prefixOut
end

-- Format the number to remove leading zeros
local function formatNumber(num)
    return tostring(num):gsub("^0+", "")
end

-- Draw function to generate the license plate
return function(PlateDesign, plateType, Prefix, Number, Postfix)
    text.font = 'arialbold.ttf'
    drawPlateText = nil

    -- Load the design script for the selected plate design
    local designScript = string.format("PlateTypes/%s.lua", PlateDesign)
    if fs.exists(designScript) then dofile(designScript) end

    -- Set the background and normals for the plate
    plate.background = string.format("PlateTypes/%s_bg.png", PlateDesign)
    plate.normals = string.format("PlateTypes/%s_nm.png", PlateDesign)
    plate.light = -90

    -- Set text properties
    text.color = '#FFFFFF'
    text.weight = text.weight or FontWeight.Normal
    text.kerning = text.kerning or -4
    text.spaces = text.spaces or 48
    text.size = text.size or 150

    local prefixOut, numberOut, postfixOut

    -- Generate the output based on the selected plate type
    if plateType == "Custom" then
        prefixOut = Prefix or ""
        numberOut = Number and formatNumber(Number) or ""
        postfixOut = Postfix or ""

    elseif plateType == "Standard" then
        local stateConfig = statePrefixes[math.random(#statePrefixes)]
        prefixOut = generatePrefixString(stateConfig)
        numberOut = tostring(math.random(1, 9999))
        postfixOut = stateConfig.postfix and getRandomElement(stateConfig.postfix) or ""

    elseif plateType == "Special" then
        local specialConfig = specialPrefixes[math.random(#specialPrefixes)]
        prefixOut = type(specialConfig.prefix) == "table" and getRandomElement(specialConfig.prefix) or specialConfig.prefix
        numberOut = tostring(math.random(1, 9999))
        if specialConfig.postfix then
            postfixOut = type(specialConfig.postfix) == "number" and string.char(64 + math.random(26)) or specialConfig.postfix
        else
            postfixOut = ""
        end
        if specialConfig.font then
            text.font = specialConfig.font
        end
    end

    -- Concatenate the parts of the plate text
    local parts = {prefixOut or ""}
    if numberOut ~= "" then table.insert(parts, numberOut) end
    if postfixOut ~= "" then table.insert(parts, postfixOut) end
    local plateText = table.concat(parts, " ")

    -- Draw the plate text based on the design
    if type(drawPlateText) == "function" then
        if PlateDesign:sub(1, 2) == "UK" then
            drawPlateText(nil, prefixOut, numberOut, postfixOut)
        else
            drawPlateText(plateText)
        end
    end
end
