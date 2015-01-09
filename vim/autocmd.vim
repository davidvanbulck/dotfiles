" This came from Greg V's dotfiles:
"      https://github.com/myfreeweb/dotfiles
" Feel free to steal it, but attribution is nice
"
" Thanks: see vimrc
" https://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save

" File types
au BufRead,BufNewFile *.{mdown,ronn} setf markdown
au BufRead,BufNewFile SCons* setf python
au BufRead,BufNewFile *.gradle setf groovy
au BufRead,BufNewFile *.scaml setf haml
au BufRead,BufNewFile *.sjs setf javascript
au BufRead,BufNewFile *.swig setf htmldjango
au BufRead,BufNewFile quakelive.cfg setf quake
au BufRead,BufNewFile *.{css,sass,scss,less,styl} setlocal iskeyword+=-
au BufRead,BufNewFile *.{jar,war,ear,sar} setf zip
au BufRead,BufNewFile *.fish setf tcsh
au BufRead,BufNewFile *psqlrc setf sql
au BufRead,BufNewFile gitconfig setf gitconfig
au BufRead,BufNewFile gitconfig setlocal noexpandtab

" Completion
au BufRead,BufNewFile *.{css,sass,scss,less,styl} setlocal omnifunc=csscomplete#CompleteCSS
au FileType html setlocal omnifunc=htmlcomplete#CompleteTags
au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
au FileType mail exe "normal! }"

" Folds
au FileType {vim,javascript} setlocal foldmethod=marker
au FileType coffee setlocal foldmethod=indent
au BufRead,BufNewFile {,.}zshrc,*.fish setlocal foldmethod=marker

" Line numbers
au InsertEnter * set number
au InsertLeave * set relativenumber

" Misc
function s:MkNonExDir(file, buf)
	if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
		let dir=fnamemodify(a:file, ':h')
		if !isdirectory(dir)
			call mkdir(dir, 'p')
		endif
	endif
endfunction
au BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
au BufReadPost fugitive://* setlocal bufhidden=delete
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
au VimResized * exe "normal! \<c-w>="
au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
