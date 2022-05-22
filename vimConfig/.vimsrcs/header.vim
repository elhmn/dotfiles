" ************************************************************************** "
"                                                                            "
"   header.vim                                                               "
"                                                                            "
"   By: elhmn <www.elhmn.com>                                                "
"             <nleme@live.fr>                                                "
"                                                                            "
"   Created: Sun Jun 17 19:09:23 2018                        by elhmn        "
"   Updated: Mon Sep 28 11:05:53 2020                        by elhmn        "
"                                                                            "
" ************************************************************************** "

if exists("header_loaded")
	finish "stop loading the header loaded"
endif
let	header_loaded = 1

let s:global_cpo = &cpo "store current compatible-mode
						"in local variable
set cpo&vim				"go into nocompatible-mode

"======================================

let		s:templatePath = "~/.vimsrcs/templates"
let		s:placeholders = {"filename":"<+FILENAME+>","author":"<+AUTHOR+>", "editor":"<+EDITOR+>", "creationdate":"<+CREATIONDATE+>", "updatedate":"<+UPDATEDATE+>"}
let		s:author = "elhmn"
let		s:templateMaxSize = 12

"replace a template placeholder with another string
"str : string to replace
"src : string to replace str with
function		s:ReplacePlaceholderString(str, src)
	let l:replace = ""

	for e in range(0, len(a:str) - 1)
		let l:replace .= " "
	endfor
	execute "normal /".a:str."\<cr>"
	execute "1,".s:templateMaxSize."s/".a:str."/".l:replace."/gi"
	execute "normal! \<c-o>R".a:src
	unlet l:replace
	execute "normal! gg"
endfunction

"Load header from specific template
function!		GetHeaderFromTemplate(headerFileName)
	let		l:editor = $USER

	if IsMacOs() == 1
		let		l:creationDate = system('stat -qx '.expand("%").' | grep -E  "^Access:" | cut -d ":" -f 2- | cut -d " " -f 2- | tr -d "\n"')
	else
		let		l:creationDate = strftime("%a %b %d %H:%M:%S %Y", system('stat -c %Y '.expand("%")))
	endif

	echom "fileName : ".s:templatePath."/".a:headerFileName
	execute ":r ".s:templatePath."/".a:headerFileName
	execute "normal ggdd"
	call s:ReplacePlaceholderString(s:placeholders["filename"], expand("%:t"))
	call s:ReplacePlaceholderString(s:placeholders["author"], s:author)
	call s:ReplacePlaceholderString(s:placeholders["editor"], l:editor)
	call s:ReplacePlaceholderString(s:placeholders["creationdate"], l:creationDate)
	call s:ReplacePlaceholderString(s:placeholders["updatedate"], strftime("%a %b %d %H:%M:%S %Y"))
endfunction

"Check if header already exist
function!		DoesHeaderExist()
	execute "normal! gg"

	"exclude 42 file header
 	if search('+#+#+#+#+#+', 'cn', s:templateMaxSize) != 0
		execute "normal! \<c-o>"
		return 1
	endif

	execute "normal! gg"
	if search('By:.*<.*>', 'cn', s:templateMaxSize) == 0
		execute "normal! \<c-o>"
		return 1
	endif
	execute "normal! \<c-o>"
	return 0
endfunction

"Save update data
function		SaveUpdateData()
	"Check if header already exist
	let		l:updators = []
	let		l:editor = $USER

	if expand("%:e") =~# "^tpl$"
		return 0
	endif
	if DoesHeaderExist() != 0
		return 0
	endif
	execute ':1,'.s:templateMaxSize.'s/\(Updated: \)\(.*[0-9]\{2}:[0-9]\{2}:[0-9]\{2} [0-9]\{4}\)\(.*by.*\)/\1'.strftime("%a %b %d %H:%M:%S %Y").'\3/gi'
	execute ':1,'.s:templateMaxSize.'s/\(Updated: \)\(.*[0-9]\{2}:[0-9]\{2}:[0-9]\{2} [0-9]\{4}\)\(.*by \)\zs\(.\{'.len(s:placeholders["editor"]).'}\)\ze\(.*\)/'.s:placeholders["editor"].'/gi'
	call s:ReplacePlaceholderString(s:placeholders["editor"], l:editor)
	execute "normal! \<c-o>\<c-o>"
	return 1
endfunction

"Add a header to a file
function!		AddHeader()
	"Check if header already exist
	if DoesHeaderExist() == 0
		return 0
	endif
	let l:fileType = expand("%:e")
	let l:fileName = expand("%:t")
	let l:cHeaderFile = "cHeader.tpl"
	let l:phpHeaderFile = "phpHeader.tpl"
	let l:hashHeaderFile = "hashHeader.tpl"
	let l:vimHeaderFile = "vimHeader.tpl"
	let l:htmlHeaderFile = "htmlHeader.tpl"
	let l:headerFile = l:hashHeaderFile

	if l:fileType =~# '^\(c\|cpp\|js\|h\|hpp\|cc\|css\|go\)$'
		let l:headerFile = l:cHeaderFile
	elseif l:fileType =~# '^\(php\)$'
		let l:headerFile = l:phpHeaderFile
	elseif l:fileType =~# '^\(html\)$'
		let l:headerFile = l:htmlHeaderFile
	elseif  l:fileName =~# '^.vimrc$' || l:fileType =~# '^\(vim\)$'
		let l:headerFile = l:vimHeaderFile
	endif
	execute "normal! ggO"
	call GetHeaderFromTemplate(l:headerFile)
endfunction

"Update header creation time
function!		UpdateHeaderCreationTime()

endfunction

function		IsMacOs()
	if has("unix") && system('uname') =~ 'Darwin'
		return 1
	endif
	return 0
endfunction


noremap <Sid>AddHeader : call <Sid>AddHeader()<cr>
noremap <silent> <c-h><c-h> : call AddHeader()<cr>
autocmd BufWritePost * call SaveUpdateData()

"======================================

let &cpo = s:global_cpo	"must be added at the end of the script
