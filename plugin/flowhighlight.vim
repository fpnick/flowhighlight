" --------------------------------
" Add our plugin to the path
" --------------------------------
python import sys
python import vim
python sys.path.append(vim.eval('expand("<sfile>:h")'))

" --------------------------------
"  Function(s)
" --------------------------------
function! TemplateExample()
" :normal mT
python << endOfPython

from flowhighlight import find_flow

vim.current.buffer[:] = find_flow(vim.current.buffer[:])

endOfPython

let i = 0
while i < s:lcolor_max
   let match_pat = '.*flowhighlightlevel'.string(i)
   exec 'syn match '. s:lcolor_grp . i  . ' "' . match_pat . '" containedin=ALL'
   let i = i+1
endw

endfunction

" --------------------------------
"  Expose our commands to the user
" --------------------------------
command! Example call TemplateExample()

" Define colors for Line highlight

if !exists('g:lcolor_bg')
   let g:lcolor_bg = "purple,seagreen,violet,lightred,lightgreen,lightblue,darkmagenta,slateblue"
endif

if !exists('g:lcolor_fg')
   let g:lcolor_fg = "white,white,black,black,black,black,white,white"
endif

if !exists('g:lcolor_bg_cterm')
   let g:lcolor_bg_cterm = "Blue,Green,Cyan,Red,Yellow,Magenta,Brown,LightGray"
endif

if !exists('g:lcolor_fg_cterm')
   let g:lcolor_fg_cterm = "White,White,White,White,White,White,Black,Black"
endif
" #############################################################################
" HighlightInitL: Initialize the highlight groups for line highlight
" Based on 'MultipleSearchInit' function developed by Dan Sharp in 
" MultipleSearch2.vim at http://www.vim.org/scripts/script.php?script_id=1183 
function! s:HighlightInitFH()
   let s:lcolor_grp = "FlowHiColor"
   let s:lcolor_n = 0

   let s:lcolor_max = s:Min(s:ItemCount(g:lcolor_bg . ','), s:ItemCount(g:lcolor_fg . ','))

   let ci = 0
   while ci < s:lcolor_max
      let bgColor = s:Strntok(g:lcolor_bg, ',', ci + 1)
      let fgColor = s:Strntok(g:lcolor_fg, ',', ci + 1)
      let bgColor_cterm = s:Strntok(g:lcolor_bg_cterm, ',', ci + 1)
      let fgColor_cterm = s:Strntok(g:lcolor_fg_cterm, ',', ci + 1)
     
      exec 'hi ' . s:lcolor_grp . ci .
         \ ' guifg =' . fgColor . ' guibg=' . bgColor
         \ ' ctermfg =' . fgColor_cterm . ' ctermbg=' . bgColor_cterm
     
      let ci = ci + 1
   endw
endfunction
" Min: Returns the minimum of the given parameters.
" Developed by Dan Sharp in MultipleSearch2.vim at
" http://www.vim.org/scripts/script.php?script_id=1183 
function! s:Min(...)
    let min = a:1
    let index = 2
    while index <= a:0
        execute "if min > a:" . index . " | let min = a:" . index . " | endif"
        let index = index + 1
    endwhile
    return min
endfunction
" Strntok: Utility function to implement C-like strntok() by Michael Geddes
" and Benji Fisher at http://groups.yahoo.com/group/vimdev/message/26788
function! s:Strntok( s, tok, n)
    return matchstr( a:s.a:tok[0], '\v(\zs([^'.a:tok.']*)\ze['.a:tok.']){'.a:n.'}')
endfunction
" ItemCount: Returns the number of items in the given string.
" Developed by Dan Sharp in MultipleSearch2.vim at
" http://www.vim.org/scripts/script.php?script_id=1183 
function! s:ItemCount(string)
    let itemCount = 0
    let newstring = a:string
    let pos = stridx(newstring, ',')
    while pos > -1
        let itemCount = itemCount + 1
        let newstring = strpart(newstring, pos + 1)
        let pos = stridx(newstring, ',')
    endwhile
    return itemCount
endfunction
" ItemCount: Returns the number of items in the given string.
" Developed by Dan Sharp in MultipleSearch2.vim at
" http://www.vim.org/scripts/script.php?script_id=1183 
function! s:ItemCount(string)
    let itemCount = 0
    let newstring = a:string
    let pos = stridx(newstring, ',')
    while pos > -1
        let itemCount = itemCount + 1
        let newstring = strpart(newstring, pos + 1)
        let pos = stridx(newstring, ',')
    endwhile
    return itemCount
endfunction

" #############################################################################

call s:HighlightInitFH()
