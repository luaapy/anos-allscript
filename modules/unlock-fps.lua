local Module = {}

function Module.start()
    setfpscap(999)
end

function Module.stop()
    setfpscap(60)
end

return Module
