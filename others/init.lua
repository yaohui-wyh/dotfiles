hs.window.animationDuration = 0
units = {
    right50       = { x = 0.70, y = 0.00, w = 0.50, h = 1.00 },
    left50        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
    top50         = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
    bot50         = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
    maximum       = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 }
}

mash = { 'ctrl', 'option', 'cmd' }
-- up/down/left/right
hs.hotkey.bind(mash, 'up', function() hs.window.focusedWindow():move(units.top50,    nil, true) end)
hs.hotkey.bind(mash, 'down', function() hs.window.focusedWindow():move(units.bot50,     nil, true) end)
hs.hotkey.bind(mash, 'left', function() hs.window.focusedWindow():move(units.left50,      nil, true) end)
hs.hotkey.bind(mash, 'right', function() hs.window.focusedWindow():move(units.right50,      nil, true) end)

-- move window to next monitor
hs.hotkey.bind(mash, 'n', function()
 -- get the focused window
  local win = hs.window.focusedWindow()
  -- get the screen where the focused window is displayed, a.k.a. current screen
  local screen = win:screen()
  -- compute the unitRect of the focused window relative to the current screen
  -- and move the window to the next screen setting the same unitRect
  win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)

-- maximum / center
hs.hotkey.bind(mash, 'm', function() hs.window.focusedWindow():move(units.maximum,  nil, true) end)
hs.hotkey.bind(mash, 'c', function() hs.window.focusedWindow():centerOnScreen(nil, true, 0) end)

-- resizeIn / resizeOut
function resizeWindowInSteps(increment)
    screen = hs.window.focusedWindow():screen():frame()
    window = hs.window.focusedWindow():frame()
    wStep = math.floor(screen.w / 12)
    hStep = math.floor(screen.h / 12)
    x = window.x
    y = window.y
    w = window.w
    h = window.h
    if increment then
        xu = math.max(screen.x, x - wStep)
        w = w + (x-xu)
        x=xu
        yu = math.max(screen.y, y - hStep)
        h = h + (y - yu)
        y = yu
        w = math.min(screen.w - x + screen.x, w + wStep)
        h = math.min(screen.h - y + screen.y, h + hStep)
    else
        noChange = true
        notMinWidth = w > wStep * 3
        notMinHeight = h > hStep * 3

        snapLeft = x <= screen.x
        snapTop = y <= screen.y
        -- add one pixel in case of odd number of pixels
        snapRight = (x + w + 1) >= (screen.x + screen.w)
        snapBottom = (y + h + 1) >= (screen.y + screen.h)

        b2n = { [true]=1, [false]=0 }
        totalSnaps = b2n[snapLeft] + b2n[snapRight] + b2n[snapTop] + b2n[snapBottom]

        if notMinWidth and (totalSnaps <= 1 or not snapLeft) then
            x = x + wStep
            w = w - wStep
            noChange = false
        end
        if notMinHeight and (totalSnaps <= 1 or not snapTop) then
            y = y + hStep
            h = h - hStep
            noChange = false
        end
        if notMinWidth and (totalSnaps <= 1 or not snapRight) then
            w = w - wStep
            noChange = false
        end
        if notMinHeight and (totalSnaps <= 1 or not snapBottom) then
            h = h - hStep
            noChange = false
        end
        if noChange then
            x = notMinWidth and x + wStep or x
            y = notMinHeight and y + hStep or y
            w = notMinWidth and w - wStep * 2 or w
            h = notMinHeight and h - hStep * 2 or h
        end
    end
    hs.window.focusedWindow():move({x=x, y=y, w=w, h=h}, nil, true, 0)
end

hs.hotkey.bind(mash, '-', function() resizeWindowInSteps(false) end)
hs.hotkey.bind(mash, '=', function() resizeWindowInSteps(true) end)
