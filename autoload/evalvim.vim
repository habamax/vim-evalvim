"" run selected (or text object) vimscript
function! evalvim#run(...)
    if !a:0
        let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    endif
    let sel_save = &selection
    let &selection = "inclusive"
    let clipboard_save = &clipboard
    let &clipboard = ""

    if a:1 == 'char'    " Invoked from Visual mode, use gv command.
        silent exe 'normal! gvy'
    elseif a:1 == 'line'
        silent exe "normal! '[V']y"
    else
        silent exe 'normal! `[v`]y'
    endif

    " Next lines should be transformed or an error would be raised
    " echo 'hello'.
    "   \'world'
    "
    " to
    " echo 'hello'.'world'
    "

    if !has("patch-8.2.0997")
        let @" = substitute(@", '\n\s*\\', '', 'g')
    endif

    if get(g:, "evalvim_capture_output", v:true)
        redir => output
        @"
        redir END
        if output !~ '^\s*$'
            let @* = substitute(output, '^\n\+', '', '')."\n"
            let @" = @*
        endif
    else
        @"
    endif

    let &selection = sel_save
    let &clipboard = clipboard_save
endfunction
