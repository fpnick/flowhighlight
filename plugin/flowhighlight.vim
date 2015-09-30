" File: flowhighlight.vim
" Author: Fabian P. Nick <fp.nick@gmail.com>
" Version: 0.1
" Description: 
"   Highlights if-else-endif structures in different colors based on
"   their 'level' in the program flow. 
"   As of October 2015 only works with Fortran.
"   VERY EARLY DEVELOPMENT VERSION!
" Uasge:
"   Use the 'FlowHighlight' command to highlight control structures.
"   Use 'FlowHighlightClear' to disable highlights.
" Configuration:
"   To define custom colors set the following variables
"     g:lcolor_bg - Background color for line highlighting
"     g:lcolor_fg - Foreground color for line highlighting
"     g:pcolor_bg - Background color for pattern highlighting
"     g:pcolor_fg - Foreground color for pattern highlighting
" Limitation:
"   Only works with a very limited FORTRAN syntax
" Acknowledgement:
"   Thanks to Amit Sethi, Dan Sharp, Michael Geddes and Benji Fisher
"   for their wonderful pieces of code.
"   Also thanks to Jarrod Taylor for his Vim Plugin framework.

python import sys
python import vim
python sys.path.append(vim.eval('expand("<sfile>:h")'))

" Main function to highlight control structures.
function! FlowHighlight()

" Python script adding 'tags' to control stuctures that are used to
" highlight the structures later.
" Also writes maximal 'depth' of control structures to the last line
" of the file.
python << endOfPython
from flowhighlight import find_flow
old_buffer = vim.current.buffer
vim.current.buffer[:] = find_flow(vim.current.buffer[:])
endOfPython

:normal mT

" Get maximum 'depth' of structures in this file
:normal G
let g:fhl_max_level = eval(getline("."))
:normal dd

" For each level, highlight the control structures
let i = 0
while i <= g:fhl_max_level
   :normal gg
   let curr_line = line(".")
   let last_line = -1
   while curr_line > last_line
      let last_line = curr_line
      let match_pat = 'flowhighlightlevel'.string(i)
      execute 'normal /' . match_pat . ''
      let curr_line = line(".")
      let match_pat = '.*\%'.line(".").'l.*'
      exec 'syn match '. s:lcolor_grp . i  . ' "' . match_pat . '" containedin=ALL'
   endw
   let match_pat = '!flowhighlightlevel'.string(i)
   execute 'normal :%s/' . match_pat . '//g'
   let i = i+1
endw

:normal 'T
endfunction

" Clear highlights.
function! FlowHighlight_clear()
   let i = 0
   while i <= g:fhl_max_level
      exec 'syn clear ' . s:lcolor_grp . i
      let i = i+1
   endw
endfunction

" --------------------------------
"  Expose our commands to the user
" --------------------------------
command! FlowHighlight call FlowHighlight()
command! FlowHighlightClear call FlowHighlight_clear()

" #############################################################################
" The code after this line is from highlight.vim
" (http://www.vim.org/scripts/script.php?script_id=1599) by Amit Sethi.


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
" HighlightInitFH: Initialize the highlight groups for line highlight
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
" #############################################################################

call s:HighlightInitFH()
