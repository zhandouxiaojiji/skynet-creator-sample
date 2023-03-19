local skynet = require "skynet"
local function test_openai()
    local api_key = skynet.getenv "openai_api_key"
    local organization = skynet.getenv "openai_organization"
    if not api_key or api_key == "" then
        print "api_key not configure"
        return
    end
    local openai = skynet.newservice("openai")
    skynet.call(openai, "lua", "init", {
        api_key = api_key,
        organization = organization,
        timeout = 6000,
    })
    -- skynet.call(openai, "lua", "req_organization", "text-davinci-003")
    local resp = skynet.call(openai, "lua", "completions", "Hello GPT")
    local content = resp.choices[1].message.content
    print("you:", "Hello GPT")
    print("gpt:", content)
end

test_openai()