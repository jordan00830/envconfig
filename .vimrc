set nocompatible
set ic
set scs
set ls=2

set bs=2		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=100		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set tabstop=2
set encoding=utf-8
set fileencodings=cp-960,utf-8
set sw=2
set notitle
set hidden
set vb t_vb=
set makeprg=gmake
set wildmenu                                                                    
set wildignore=*.bak,*.o,*.e,*~,*.so
set wildmode=list:full
set ssop=curdir,folds,buffers

fu! FileEncoding()
	if &fileencoding == ''
		return "N/A"
	else
		return &fenc
		endif
endf 
let &statusline='%<[%n] %f %m%= %h%r %-19([%p%%] %3l,%02c%03V%)%y [%{FileEncoding()}]'

set incsearch
set diffopt=filler,iwhite
set path+=/home/y/include,/home/y/include/g++,/usr/include,/usr/include/c++,/usr/include/g++,/usr/local/include,**
"highlight Search term=reverse ctermbg=green ctermfg=7
highlight StatusLine ctermfg=blue ctermbg=white

"if version >= 700
"set cul
"highlight CursorLine cterm=none ctermbg=DarkGrey
"endif

filetype on
filetype plugin on
filetype indent on
:map <F2> :shell <CR>
:map <F3> :TlistToggle <CR>
:map <F4> :Explore <CR>
:map <F5> :make <CR>
:map <F6> :LUWalk <CR>
:map <F7> :LUBufs <CR>
:map <F9> :mksession! ~/.session/default.vim <CR>
:map <F10> :so ~/.session/default.vim <CR>
:map <F11> :bd <CR>
:map <F12> :bn <CR>
:imap <Esc>Oq 1
:imap <Esc>Or 2
:imap <Esc>Os 3
:imap <Esc>Ot 4
:imap <Esc>Ou 5
:imap <Esc>Ov 6
:imap <Esc>Ow 7
:imap <Esc>Ox 8
:imap <Esc>Oy 9
:imap <Esc>Op 0
:imap <Esc>On .
:imap <Esc>OQ /
:imap <Esc>OR *
:imap <Esc>Ol +
:imap <Esc>OS -


let g:calendar_focus_today = 1

if !has("gui_running")
	set background=dark
endif

if has("folding")
	set foldmethod=marker
endif

let g:dbext_default_profile_ora1 = 'type=ORA:user=pool_ora2@pool01:passwd=pool_ora2'
let g:dbext_default_profile_order = 'type=ORA:user=orderuser@AUCTRT01:passwd=im_apuser66'
let g:dbext_default_profile_beta10 = 'type=MYSQL:user=orderuser:passwd=1109:host=beta10.ac.tpe.yahoo.com'
let g:dbext_default_inputdialog_cancel_support = 0
let g:dbext_default_history_size = 100
let g:dbext_default_history_file = '~/.dbext_sql_history.txt'

let g:bufExplorerSortBy="name"

let g:no_lookupfile_maps=1

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

let os = substitute(system("uname"), '\n', "", "")
if os == "Linux"
	let g:Tlist_Ctags_Cmd="/usr/bin/ctags"
else
	let g:Tlist_Ctags_Cmd="/usr/local/bin/exctags"
endif

let g:Tlist_Inc_Winwidth=0
let g:Tlist_GainFocus_On_ToggleOpen = 1

let TAGS_PATH = getcwd()
while strlen(TAGS_PATH) > 0
	if filereadable(TAGS_PATH . "/tags")
		execute "set tags^=" . TAGS_PATH . "/tags"
		break
	endif
	let TAGS_PATH = substitute(TAGS_PATH, '/[^/]*$', "", "")
endwhile
