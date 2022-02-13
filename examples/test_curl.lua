local curl = require "cURL"

-- HTTP Get
curl.easy{
    url = 'http://httpbin.org/get',
    httpheader = {
      "X-Test-Header1: Header-Data1",
      "X-Test-Header2: Header-Data2",
    },
    writefunction = io.stderr -- use io.stderr:write()
  }
  :perform()
:close()