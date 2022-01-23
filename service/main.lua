local skynet = require "skynet"
local cjson = require "cjson.safe"
local openssl = require "openssl"
local uuid = require "uuid"

skynet.start(function ()
    print "hello skynet!"
    print("test cjson", cjson.encode {aa = 1})
    print("test openssl", openssl.base64("hello"))
    print("test uuid", uuid())
end)
