" Vim global plugin for correcting typing mistakes
" Last Change: 2000 Oct 15
" Maintainer: Bram Moolenaar <Bram@vim.org>
" License:	This file is placed in the public domain.

if exists("loaded_rspec_runner")
  finish
endif
let loaded_rspec_runner = 1

let s:save_cpo = &cpo
set cpo&vim

if !hasmapto('<Plug>RSpecRunnerCursor') && mapcheck("ff") == ""
  map <unique> ff  <Plug>RSpecRunnerCursor
endif

if !hasmapto('<Plug>RSpecRunnerLast') && mapcheck("fl") == ""
  map <unique> fl  <Plug>RSpecRunnerLast
endif

noremap <unique> <script> <Plug>RSpecRunnerCursor  <SID>Cursor
noremap <unique> <script> <Plug>RSpecRunnerLast  <SID>Last

noremap <SID>Cursor  :call <SID>Cursor()<CR>
noremap <SID>Last  :call <SID>Last()<CR>

function s:Cursor()
  let s:test = "silent !echo bundle exec rspec --drb ".expand("%").":".line(".")." | tee /tmp/rspec_runner"
  execute s:test
endfunction

function s:Last()
  execute s:test
endfunction

let &cpo = s:save_cpo
