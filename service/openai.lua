local skynet = require "skynet"
local httpc = require "http.httpc"
local cjson = require "cjson.safe"
local cURL = require "cURL"

local api_key
local organization

local function common_header()
    return {
        "Content-Type: application/json",
        "Authorization: Bearer " .. api_key,
    }
end

local function post(url, body)
    local header = common_header()
    local resp

    c = cURL.easy{
        url = url,
        post = true,
        httpheader = header,
        writefunction = function(data)
            resp = data
            -- print(data)
        end,
        postfields = cjson.encode(body)
    }
    c:perform()
    c:close()

    return resp and cjson.decode(resp) or nil
end

local CMD = {}
function CMD.init(args)
    api_key = assert(args.api_key)
    organization = args.organization
    if args.timeout then
        httpc.timeout = args.timeout
    end
end

function CMD.req_organization(model)
    local header = {
        "Authorization: Bearer " .. api_key,
        "OpenAI-Organization:" .. organization
    }

    local url = "https://api.openai.com/v1/models"
    if model then
        url = url .. "/" .. model
    end
    local resp
    c = cURL.easy{
        url = url,
        httpheader = {
            "Authorization: Bearer " .. api_key,
            "OpenAI-Organization: " .. organization
        },
        writefunction = function(data)
            resp = data
        end
    }
    c:perform()
    c:close()
    return resp and cjson.decode(resp) or nil
end

function CMD.completions(content)
    local header = common_header()
    local body = {
        model = "gpt-3.5-turbo",
        messages = {{role = "user", content = content}},
        temperature = 0.7
    }
    return post("https://api.openai.com/v1/chat/completions", body)
end

skynet.start(function()
    skynet.dispatch("lua", function(_, _, cmd, ...)
        local f = assert(CMD[cmd], cmd)
        skynet.retpack(f(...))
    end)
end)

