" Indenting rules
autocmd Filetype python setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype r setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype html setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype xhtml setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype htmldjango setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype js setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype sh setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype scala setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent

" Set filetypes baseed on extensions
autocmd BufNewFile,BufRead *.ddl set filetype=sql
