local skynet = require "skynet"
local cjson = require "cjson.safe"
local openssl = require "openssl"

skynet.start(function ()
    print "hello skynet!"
    print("test cjson", cjson.encode {aa = 1})
    print("test openssl", openssl.base64("hello"))
end)
