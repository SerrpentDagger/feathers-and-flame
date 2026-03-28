" Vim syntax file
" Language:    scajl by SerpentDagger (SerrpentDagger GitHub)
" Maintainer:  SerpentDagger
" Loosely adapted from the rout.vim syntax file for R output files by Jakson Aquino

if !has("nvim")
    finish
endif
if exists("b:current_syntax")
    finish
endif

" setlocal iskeyword=@,48-57,_,.

syn case match

" Normal text
" syn match Normal "."

" Constants
syn keyword Character return exit call echo exec runscr runlab impscr read IMPORT up PREV new
syn keyword Boolean true
syn keyword Boolean false
syn keyword Repeat for while if equals nequals and or not compare sleep
syn keyword Keyword import pack print_all_vars print print_debug
syn keyword Function var var_if var_array var_array_fill is_var test enforce enforce_one assert of_type get_type

" operators
syn match Operator "[\.,;+{}()\[\]/@#\^\|&]"
syn match Repeat "[><=:\?\!]"
syn match Character "[-~]"
syn match Function "->"
syn match Character "==\s*$"

" Calls
" syn match Boolean "\.\(?!INDEX\)\(?!len\)[a-zA-Z][a-zA-Z0-9_]*"
" syn match Function "\.[a-zA-Z][a-zA-Z0-9_]*"
" syn match Identifier "\s[A-Z][a-zA-Z]*\."
syn keyword Number len null sub add mult divi int inc dec INDEX
" highlight Italic cterm=italic

" integer
syn match Integer "\<\d\+L"
syn match Integer "\<0x\([0-9]\|[a-f]\|[A-F]\)\+L"
syn match Integer "\<\d\+[Ee]+\=\d\+L"

" number with no fractional part or exponent
syn match Number "\<\d\+\>"
syn match Number "-\<\d\+\>"
" hexadecimal number
syn match Number "\<0x\([0-9]\|[a-f]\|[A-F]\)\+"

" floating point number with integer and fractional parts and optional exponent
syn match Float "\<\d\+\.\d*\([Ee][-+]\=\d\+\)\="
syn match Float "-\d\+\.\d*\([Ee][-+]\=\d\+\)\="
" floating point number with no integer part and optional exponent
syn match Float "\<\.\d\+\([Ee][-+]\=\d\+\)\="
syn match Float "-\.\d\+\([Ee][-+]\=\d\+\)\="
" floating point number with no fractional part and optional exponent
syn match Float "\<\d\+[Ee][-+]\=\d\+"
syn match Float "-\d\+[Ee][-+]\=\d\+"

" Strings
syn region String start=/"/ skip=/\\\\\|\\"/ end=/"/ end=/$/
syn region Comment start=/<</ end=/>>/
syn region Comment start="//" end="$"
syn region Comment start="\\\\fold" end="$"

" syn region Character start="^[\-\=][\-\=][\-\=][\-\=]*\s*" end="$"
" syn region Character start="///" end="$"

" Folds
" syn region String start="^\s*\-\-[a-zA-Z]" end="^\s*return" fold
" syn match String "^\s*\-\-[a-zA-Z]"
" syn match String "^\s*return"
" syn region String start="\~\~[a-zA-Z]" end="^return$" fold
" syn region Scope start="{" end="}" transparent fold
syn sync fromstart
set foldmethod=indent

let b:current_syntax = "scajl"

" vim: ts=8 sw=4
