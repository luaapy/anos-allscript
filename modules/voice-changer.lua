local Module = {}

function Module.start()
    -- Voice changer not possible in client-side Roblox
    -- This is a placeholder module
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Voice Changer";
        Text = "Voice modification not supported in client scripts";
        Duration = 3;
    })
end

function Module.stop()
end

return Module
