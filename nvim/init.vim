"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"        _   _       _                  _____             __ _               "
"       | \ | |     (_)                / ____|           / _(_)              "
"       |  \| |_   ___ _ __ ___       | |     ___  _ __ | |_ _  __ _         "
"       | . ` \ \ / / | '_ ` _ \      | |    / _ \| '_ \|  _| |/ _` |        "
"       | |\  |\ V /| | | | | | |     | |___| (_) | | | | | | | (_| |        "
"       |_| \_| \_/ |_|_| |_| |_|      \_____\___/|_| |_|_| |_|\__, |        "
"                                                               __/ |        "
"                                                              |___/         "
"                                                                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The above ASCII art is generated using service provided in this webpage:
" http://tinyurl.com/y6szckgd.

" Main configurations
let g:is_win = has('win32') || has('win64')
let g:is_linux = has('unix') && !has('macunix')
let g:is_mac = has('macunix')

let g:nvim_config_root = expand('<sfile>:p:h')
let g:config_file_list = [
    \ 'variables.vim',
    \ 'functions.vim',
    \ 'plugins.vim',
    \ 'options.vim',
    \ 'mappings.vim',
    \ 'autocommands.vim',
    \ ]

for s:fname in g:config_file_list
    execute 'source ' . g:nvim_config_root . '/' . s:fname
endfor

" Inspiration / resources / sources:
" https://github.com/jdhao/nvim-config
" https://github.com/ddrscott/config-nvim
