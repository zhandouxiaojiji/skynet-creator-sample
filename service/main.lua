local skynet = require "skynet"
local cjson = require "cjson.safe"

skynet.start(function ()
    print "hello skynet!"
    print(cjson.encode {aa = 1})
end)
