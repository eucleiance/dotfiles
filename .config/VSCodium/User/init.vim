" packadd quickscope

" execute 'luafile ' . stdpath('config') . '/lua/settings.lua'
function! s:manageEditorSize(...)
    let count = a:1
    let to = a:2
    for i in range(1, count ? count : 1)
        call VSCodeNotify(to == 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
    endfor
endfunction

function! s:vscodeCommentary(...) abort
    if !a:0
        let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    elseif a:0 > 1
        let [line1, line2] = [a:1, a:2]
    else
        let [line1, line2] = [line("'["), line("']")]
    endif

    call VSCodeCallRange("editor.action.commentLine", line1, line2, 0)
endfunction

function! s:openVSCodeCommandsInVisualMode()
    normal! gv
    let visualmode = visualmode()
    if visualmode == "V"
        let startLine = line("v")
        let endLine = line(".")
        call VSCodeNotifyRange("workbench.action.showCommands", startLine, endLine, 1)
    else
        let startPos = getpos("v")
        let endPos = getpos(".")
        call VSCodeNotifyRangePos("workbench.action.showCommands", startPos[1], endPos[1], startPos[2], endPos[2], 1)
    endif
endfunction

function! s:openWhichKeyInVisualMode()
    normal! gv
    let visualmode = visualmode()
    if visualmode == "V"
        let startLine = line("v")
        let endLine = line(".")
        call VSCodeNotifyRange("whichkey.show", startLine, endLine, 1)
    else
        let startPos = getpos("v")
        let endPos = getpos(".")
        call VSCodeNotifyRangePos("whichkey.show", startPos[1], endPos[1], startPos[2], endPos[2], 1)
    endif
endfunction

" Better Navigation
nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>

nnoremap <silent> <S-h> :call VSCodeNotify('workbench.action.previousEditor')<CR>
xnoremap <silent> <S-h> :call VSCodeNotify('workbench.action.previousEditor')<CR>

nnoremap <silent> <S-l> :call VSCodeNotify('workbench.action.nextEditor')<CR>
xnoremap <silent> <S-l> :call VSCodeNotify('workbench.action.nextEditor')<CR>


cnoremap <expr> H getcmdtype() == '/' ? 'H' : '<C-b>'
cnoremap <expr> L getcmdtype() == '/' ? 'L' : '<C-f>'


nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>

" Bind C-/ to vscode commentary since calling from vscode produces double comments due to multiple cursors
xnoremap <expr> <C-/> <SID>vscodeCommentary()
nnoremap <expr> <C-/> <SID>vscodeCommentary() . '_'

nnoremap <silent> <C-w>_ :<C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>

" nnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
" xnoremap <silent> <Space> :<C-u>call <SID>openWhichKeyInVisualMode()<CR>

xnoremap <silent> <C-P> :<C-u>call <SID>openVSCodeCommandsInVisualMode()<CR>

xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

" Simulate same TAB behavior in VSCode
nmap <Tab> :Tabnext<CR>
nmap <S-Tab> :Tabprev<CR>

set clipboard=unnamedplus

function! s:formatSelectedLines()
    normal! gv
    let visualmode = visualmode()
    if visualmode == "V"
        let startLine = line("v")
        let endLine = line(".")
        call VSCodeNotifyRange("editor.action.formatSelection", startLine, endLine, 1)
    else
        let startPos = getpos("v")
        let endPos = getpos(".")
        call VSCodeNotifyRangePos("editor.action.formatSelection", startPos[1], endPos[1], startPos[2], endPos[2], 1)
    endif
endfunction

xnoremap <silent> = :<C-u>call <SID>formatSelectedLines()<CR>

" Make Searches Case-Insensitive
set ignorecase
" Make Searched Case-Sensitive if the search contains UpperCase Letter
set smartcase



-- Unmap <Space> in normal mode if it's conflicting elsewhere
vim.keymap.del("n", "<Space>")

-- Add this Lua-based keybinding for <Space> in normal mode
vim.keymap.set("n", "<Space>", function()
  vim.fn["VSCodeNotify"]("whichkey.show")
end, { noremap = true, silent = true })

-- Adjust the <Space> binding for visual mode
vim.keymap.set("x", "<Space>", function()
  vim.fn["VSCodeNotify"]("whichkey.show")
end, { noremap = true, silent = true })
