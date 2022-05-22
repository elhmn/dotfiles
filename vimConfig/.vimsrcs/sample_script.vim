" ************************************************************************** "
"                                                                            "
"   sample_script.vim                                                        "
"                                                                            "
"   By: elhmn <www.elhmn.com>                                                "
"             <nleme@live.fr>                                                "
"                                                                            "
"   Created: Wed Jun 13 20:23:54 2018                        by elhmn        "
"   Updated: Sun Jun 17 19:12:24 2018                        by elhmn        "
"                                                                            "
" ************************************************************************** "

if exists("loaded_myscript")
	finish "stop loading the script"
	"or instead delete/unload function contained in the script
	"delfunction MyglobalFunction
endif
let	loaded_myscript=1
let s:global_cpo = &cpo "store current compatible-mode
						"in local variable
set cpo&vim				"go into nocompatible-mode

let &cpo = s:global_cpo	"must be added at the end of the script
