-- Shared helper functions for drawing plate text

-- Draw single-line plate text centered
-- @param plateText: The text to be drawn on the plate
function drawCenteredText(plateText)
    drawText(plateText or "", 0, 0, Gravity.Center)
end

-- Draw two-line UK-style plate text
-- @param prefix: The prefix of the plate
-- @param number: The number on the plate
-- @param postfix: The postfix of the plate
function drawTwoLineUKText(prefix, number, postfix)
    local plateSize = plate and plate.size or {1024, 540}
    local height = plate.size and plate.size[2] or 540
    local textSize = text.size or 120
    local centerX = -height / 2
    local lineOffsetY = textSize * 0.45

    drawText(prefix or "", centerX, -lineOffsetY, Gravity.Center)

    local lowerLine = number or ""
    if postfix and postfix ~= "" then
        lowerLine = lowerLine .. " " .. postfix
    end

    drawText(lowerLine, centerX, lineOffsetY, Gravity.Center)
end
