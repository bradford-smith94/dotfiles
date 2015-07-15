if exists("b:did_ftplugin")
    finish
endif

let b:did_ftplugin = 1 "prevents loading this twice

setlocal spell
setlocal textwidth=72
