# AppSizer Spoon for Hammerspoon

AppSizer is a configurable module (Spoon) for Hammerspoon that automatically resizes application windows to predefined sizes when they are first focused or when the F14 key is pressed. 

## Installation

To install the AppSizer Spoon, clone this repository into your `~/.hammerspoon/Spoons/` directory:

## Usage

In your Hammerspoon `init.lua` script, require the AppSizer Spoon and configure your applications with their default sizes:

```lua
local AppSizer = hs.loadSpoon("AppSizer")
AppSizer:setAppSizeMap({
    ["Telegram"] = {{w=470, h=900}, {w=1160, h=710}},
    ["Todoist"] = {{w=635, h=920}, {w=1115, h=760}},
    ["Slack"] = {{w=1300, h=780}, {w=980, h=670}},
    ["WezTerm"] = {w=1357, h=920}
})
AppSizer:start()
```

You can add as many applications as you want to the `AppSizer:setAppSizeMap(map)` function. The map should be a table where the keys are the application names and the values are tables of dimensions (with `w` for width and `h` for height).

The applications will be automatically resized to the specified dimensions the first time they are focused after Hammerspoon starts, or when the F14 key is pressed.

To stop the AppSizer, call the `stop()` function:

```lua
AppSizer:stop()
```

## Note

The `start()` function initializes an application watcher for each application in the `appSizeMap`. The watchers are stored in a global table and are not stopped when the `init.lua` script is reloaded. To ensure that old watchers are stopped when the script is reloaded, you should call the `AppSizer:stop()` function at the beginning of your `init.lua` script.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the `LICENSE.md` file for details.
