-- Shared helper functions for drawing plate text

-- Draw centered text on the plate
-- @param plateText: The text to be drawn on the plate
-- @param offsetX: Horizontal offset for the text
-- @param offsetY: Vertical offset for the text
local function drawCenteredText(plateText, offsetX, offsetY)
    drawText(plateText or "", offsetX or 0, offsetY or 0, Gravity.Center)
end

-- Draw single-line EU plate text centered
function drawEUText(plateText)
    drawCenteredText(plateText, 0, 0)
end

-- Draw single-line EV plate text centered
function drawEVText(plateText)
    drawCenteredText(plateText, 50, -36)
end

-- Draw two-line UK-style plate text
function drawTwoLineUKText(prefix, number, postfix)
    local height = plate.size and plate.size[2] or 540
    local textSize = text.size or 120
    local centerX = -height / 2
    local lineOffsetY = textSize * 0.45

    drawCenteredText(prefix, centerX, -lineOffsetY)

    local lowerLine = number or ""
    if postfix and postfix ~= "" then
        lowerLine = lowerLine .. " " .. postfix
    end

    drawCenteredText(lowerLine, centerX, lineOffsetY)
end