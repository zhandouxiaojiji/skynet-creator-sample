local skynet = require "skynet"
local lfs = require "lfs"
-- local openssl = require "openssl"
-- local uuid = require "uuid"
-- local lz4 = require "lz4"

local function test_lz4()
    local s1 = "LZ4 is a very fast compression and decompression algorithm."
    local com = lz4.new_compression_stream()
    local dec = lz4.new_decompression_stream()
    local cs1 = com:compress(s1)
    local dcs1 = dec:decompress_safe(cs1, #s1)
    assert(dcs1 == s1)
end

skynet.start(function ()
    print "hello skynet!"

    for file in lfs.dir("./examples") do
        if string.match(file, ".+%.lua$") then
            print("=========== "..file.." ===============")
            dofile("./examples/"..file)()
        end
    end
    -- print("test openssl", openssl.base64("hello"))

    -- test_lz4()
end)
