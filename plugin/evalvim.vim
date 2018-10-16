" evalvim.vim - Evaluate vim lang
"
" gyip to evaluate a para of vimscript
" gyy to evaluate a line of vimscript
" visual selection etc
"
" Maintainer:   Maxim Kim <habamax@gmail.com>
" Version:      0.1

if exists("g:loaded_evalvim") || v:version < 700
	finish
endif
let g:loaded_evalvim = 1

if !exists('g:evalvim_capture_output')
	let g:evalvim_capture_output = 1
endif

function! EvalVim(...)
	if !a:0
		let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
		return 'g@'
	endif
	let sel_save = &selection
	let &selection = "inclusive"
	let reg_save = @@
	let clipboard_save = &clipboard
	let &clipboard = ""

	if a:1 == 'char'	" Invoked from Visual mode, use gv command.
		silent exe "normal! gvy"
	elseif a:1 == 'line'
		silent exe "normal! '[V']y"
	else
		silent exe "normal! `[v`]y"
	endif

	if g:evalvim_capture_output == 1
		redir @*
		@"
		redir END
	else
		@"
	endif

	let &selection = sel_save
	let @@ = reg_save
	let &clipboard = clipboard_save
endfunction

xnoremap <expr> <Plug>(EvalVim)     EvalVim()
nnoremap <expr> <Plug>(EvalVim)     EvalVim()
nnoremap <expr> <Plug>(EvalVimLine) EvalVim() . '_'

if !hasmapto('<Plug>(EvalVim)') && maparg('gy','n') ==# ''
	xmap gy  <Plug>(EvalVim)
	nmap gy  <Plug>(EvalVim)
	omap gy  <Plug>(EvalVim)
	nmap gyy <Plug>(EvalVimLine)
endif

