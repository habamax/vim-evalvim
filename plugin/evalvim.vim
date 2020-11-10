" evalvim.vim - Evaluate/run vim script
"
" Maintainer:   Maxim Kim <habamax@gmail.com>
" Version:      1.0

if exists("g:loaded_evalvim") || v:version < 700
	finish
endif
let g:loaded_evalvim = 1

xnoremap <expr> <Plug>(EvalVim) evalvim#run()
nnoremap <expr> <Plug>(EvalVim) evalvim#run()
nnoremap <expr> <Plug>(EvalVimLine) evalvim#run() . '_'

"" example mappings
" xmap <leader>v <Plug>(EvalVim)
" nmap <leader>v <Plug>(EvalVim)
" omap <leader>v <Plug>(EvalVim)
" nmap <leader>vv <Plug>(EvalVimLine)
