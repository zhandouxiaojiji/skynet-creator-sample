local cjson = require "cjson.safe"
return function ()
    print("test cjson", cjson.encode {aa = 1})
end