" Indenting rules
autocmd Filetype python setlocal ts=4 sts=4 sw=4 foldnestmax=4 foldmethod=indent
autocmd Filetype ruby setlocal ts=4 sts=4 sw=4 foldnestmax=4 foldmethod=indent
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
autocmd BufNewFile,BufRead *.dml set filetype=sql
autocmd BufNewFile,BufRead Jenkinsfile set filetype=groovy

" Treat terragrunt files like terraform files
autocmd BufNewFile,BufRead *.hcl set filetype=terraform
autocmd BufWritePre *.hcl call terraform#fmt()

" Automatically format python files with Black formatting upon save
autocmd BufWritePre *.py execute ':Black'
