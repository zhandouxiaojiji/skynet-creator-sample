local skynet = require "skynet"
local function test_openai()
    local api_key = skynet.getenv "openai_api_key"
    if not api_key or api_key == "" then
        print "api_key not configure"
        return
    end
    local openai = skynet.newservice("openai")
    skynet.call(openai, "lua", "init", {
        api_key = api_key
    })
end

test_openai()