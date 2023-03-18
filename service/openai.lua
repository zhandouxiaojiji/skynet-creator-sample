local skynet = require "skynet"
local httpc = require "http.httpc"
local cjson = require "cjson.safe"

local api_key

local function common_header()
    return {
        ["Content-Type"] = "application/json",
        ["Authorization"] = "Bearer " .. openai_api_key,
    }
end

local CMD = {}
function CMD.init(args)
    api_key = assert(args.api_key)
    if args.timeout then
        httpc.timeout = args.timeout
    end
end

skynet.start(function()
    skynet.dispatch("lua", function(_, _, cmd, ...)
        local f = assert(CMD[cmd], cmd)
        skynet.retpack(f(...))
    end)
end)

