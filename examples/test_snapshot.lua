local lss = require "lsnapshot"
return function()
    local sss = nil
    lss.start_snapshot()
    sss = {}
    lss.dstop_snapshot(40)
end
