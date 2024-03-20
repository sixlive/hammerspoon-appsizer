local module = {}
local appSizeMap = {}
local appSizeIndex = {}
local AppsFocused = {}
local AppWatcher

function module.resizeAppWindow(win)
    if win then
        local appName = win:application():name()
        local sizes = appSizeMap[appName]

        if sizes then
            if sizes.w and sizes.h then
                sizes = { sizes }
            end

            if not appSizeIndex[appName] then
                appSizeIndex[appName] = 1
            end

            local size = sizes[appSizeIndex[appName]]
            local frame = win:frame()

            print(appName .. " resized from: " .. frame.w .. "x" .. frame.h)
            print(appName .. " resized to: " .. size.w .. "x" .. size.h)
            frame.w = size.w
            frame.h = size.h
            win:setFrame(frame)

            appSizeIndex[appName] = (appSizeIndex[appName] % #sizes) + 1
        else
            local frame = win:frame()
            print("No sizes found for " .. appName)
            print(appName .. " frame is: " .. frame.w .. "x" .. frame.h)
        end
    end
end

function module.setAppSizeMap(map)
    appSizeMap = map

    hs.hotkey.bind({}, "F14", function()
        local win = hs.window.focusedWindow()
        module.resizeAppWindow(win)
    end)
end

function module.start()
    -- Get all running apps and track them off the rip so we only trigger a re-size on launch
    local runningApps = hs.application.runningApplications()

    for _, app in ipairs(runningApps) do
        if appSizeMap[app:name()] then
            print(app:name(), ' running...')
            AppsFocused[app:name()] = true
        end
    end

    -- Setup the watcher
    AppWatcher = hs.application.watcher.new(function(appName, eventType, appObject)
        if not appSizeMap[appName] then
            return
        end

        if eventType == hs.application.watcher.terminated then
            AppsFocused[appName] = nil
        end

        if eventType == hs.application.watcher.activated then
            if not AppsFocused[appName] then
                hs.timer.doAfter(1, function()
                    local win = appObject:focusedWindow()
                    if win then
                        module.resizeAppWindow(win)
                        AppsFocused[appName] = true
                    end
                end)
            end
        end
    end)
    AppWatcher:start()
end

function module.stop()
    if AppWatcher then
        AppWatcher:stop()
    end
end

return module
