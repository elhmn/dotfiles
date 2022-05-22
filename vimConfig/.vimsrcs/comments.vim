" ************************************************************************** "
"                                                                            "
"   comments.vim                                                             "
"                                                                            "
"   By: elhmn <www.elhmn.com>                                                "
"             <nleme@live.fr>                                                "
"                                                                            "
"   Created:                                                 by elhmn        "
"   Updated: Fri Apr 10 00:41:03 2020                        by bmbarga      "
"                                                                            "
" ************************************************************************** "

if exists("comments_loaded")
	finish "stop loading the header loaded"
endif
let	comments_loaded = 1

let s:global_cpo = &cpo "store current compatible-mode
						"in local variable
set cpo&vim				"go into nocompatible-mode

"======================================
"Basic comment scripts

let		s:typeStart = ['\/\/', '#', '/*', '<\!--', '"']
let		s:typeEnd = ['\*\/', '-->']
let		s:spaceL = ' '

"Add comments ====================>
function!		Comments(sandwich)

	let		l:fileType = expand("%:e")
	let		l:fileName = expand("%:t")

"	type[0] -> start character, type[1] -> end character
	let		l:type = [s:typeStart[1], '']

	if l:fileType =~# '^\(c\|cs\|cpp\|rs\|java\|php\|js\|ts\|tsx\|h\|hpp\|cc\|css\|go\)$'
		if a:sandwich == 1
			let	l:type[0] = s:typeStart[2]
			let	l:type[1] = s:typeEnd[0]
		else
			let	l:type[0] = s:typeStart[0]
		endif
	elseif l:fileType =~# '^\(html\)$'
			let	l:type[0] = s:typeStart[3]
			let	l:type[1] = s:typeEnd[1]
	elseif  l:fileName =~# '^.vimrc$' || l:fileType =~# '^\(vim\)$'
		let	l:type[0] = s:typeStart[4]
	endif
	execute '.s/\(.*$\)/'.l:type[0].s:spaceL.'\1'.l:type[1].'/gi'
endfunction

"Remove comments ====================>
function!		RemoveComments(sandwich)
	let		l:fileType = expand("%:e")
	let		l:fileName = expand("%:t")

"	type[0] -> start character, type[1] -> end character
	let		l:type = [s:typeStart[1], '']

	if l:fileType =~# '^\(c\|cs\|cpp\|rs\|php\|js\|ts\|tsx\|h\|hpp\|cc\|css\|go\)$'
		if a:sandwich == 1
			let	l:type[0] = s:typeStart[2]
			let	l:type[1] = s:typeEnd[0]
		else
			let	l:type[0] = s:typeStart[0]
		endif
	elseif l:fileType =~# '^\(html\)$'
			let	l:type[0] = s:typeStart[3]
			let	l:type[1] = s:typeEnd[1]
	elseif  l:fileName =~# '^.vimrc$' || l:fileType =~# '^\(vim\)$'
		let	l:type[0] = s:typeStart[4]
	endif
	execute '.s/\('.l:type[0].'\)\+\('.s:spaceL.'\)\?\(.*\)'.l:type[1].'/\3/gi'
endfunction

"Add debug comments ====================>
function!		DebugComments(sandwich)

	let		l:fileType = expand("%:e")
	let		l:fileName = expand("%:t")

"	type[0] -> start character, type[1] -> end character
	let		l:type = [s:typeStart[1], '']

	if l:fileType =~# '^\(c\|cs\|cpp\|rs\|java\|php\|js\|ts\|tsx\|h\|hpp\|cc\|css\|go\)$'
		if a:sandwich == 1
			let	l:type[0] = s:typeStart[2]
			let	l:type[1] = s:typeEnd[0]
		else
			let	l:type[0] = s:typeStart[0]
		endif
	elseif l:fileType =~# '^\(html\)$'
			let	l:type[0] = s:typeStart[3]
			let	l:type[1] = s:typeEnd[1]
	elseif  l:fileName =~# '^.vimrc$' || l:fileType =~# '^\(vim\)$'
		let	l:type[0] = s:typeStart[4]
	endif
	execute '.s/\(.*$\)/'.'\1'.s:spaceL.l:type[0].s:spaceL.'Debug'.l:type[1].'/gi'
endfunction

"Remove debug comments ====================>
function!		RemoveDebugComments(sandwich)
	let		l:fileType = expand("%:e")
	let		l:fileName = expand("%:t")

"	type[0] -> start character, type[1] -> end character
	let		l:type = [s:typeStart[1], '']

	if l:fileType =~# '^\(c\|cs\|cpp\|rs\|java\|php\|js\|ts\|tsx\|h\|hpp\|cc\|css\|go\)$'
		if a:sandwich == 1
			let	l:type[0] = s:typeStart[2]
			let	l:type[1] = s:typeEnd[0]
		else
			let	l:type[0] = s:typeStart[0]
		endif
	elseif l:fileType =~# '^\(html\)$'
			let	l:type[0] = s:typeStart[3]
			let	l:type[1] = s:typeEnd[1]
	elseif  l:fileName =~# '^.vimrc$' || l:fileType =~# '^\(vim\)$'
		let	l:type[0] = s:typeStart[4]
	endif
	execute '.s/\(.*\)'.'\('.s:spaceL.'\)'.l:type[0].'\('.s:spaceL.'\)*Debug'.l:type[1].'/\1/gi'
"	execute '.s/\('.l:type[0].'\)*'.s:spaceL.'*\(.*\)'.l:type[1].'/\2/gi'
endfunction

nnoremap <silent> ee : call Comments(0)<cr>
vnoremap <silent> ee : call Comments(0)<cr>

nnoremap <silent> er : call RemoveComments(0)<cr>
vnoremap <silent> er : call RemoveComments(0)<cr>

nnoremap <silent> tt : call DebugComments(0)<cr>
vnoremap <silent> tt : call DebugComments(0)<cr>

nnoremap <silent> tr : call RemoveDebugComments(0)<cr>
vnoremap <silent> tr : call RemoveDebugComments(0)<cr>
