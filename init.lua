local module = {}
module.__index = module

-- Load the internal functions
local internal = dofile(hs.spoons.resourcePath("internal.lua"))

-- Function to set the app size map
function module:setAppSizeMap(map)
    internal.setAppSizeMap(map)
end

function module:resizeFocusedWindow()
    local win = hs.window.focusedWindow()
    internal.resizeAppWindow(win)
end

-- Function to start the module
function module:start()
    internal.start()
end

-- Function to stop the module
function module:stop()
    internal.stop()
end

return module
