function! ImportJs#Make()
  call system("touch ~/.import-js-list")
  call system("git ls-files | xargs grep '^import' | grep 'from' | egrep -v 'yarn|d.ts|.json|flow-typed' | perl -pe 's/^.+://' | grep -v '^\/\/' | grep -v '{$' | perl -nale 'print if length($_) < 120' > /tmp/.import-js-list")
  call system('cat /tmp/.import-js-list ~/.import-js-list | perl -pe s/\"/\''/g | perl -pe "s/;//g" | sort | uniq > /tmp/.import-js-list-concatenated')
  call system("cp /tmp/.import-js-list-concatenated ~/.import-js-list")
  call system("rm /tmp/.import-js-list /tmp/.import-js-list-concatenated")
endfunction

function! ImportJs#Import() abort
  let l:search = expand("<cword>")
  if empty(l:search)
    echo '[ImportJs] No search word at current cursor'
    return
  endif
  let l:command = "cat ~/.import-js-list | egrep '\\b".search."\\b'"
  let l:lines = systemlist(command)
  if (len(l:lines) == 0)
    echo '[ImportJs] No match for: '.search
    return
  endif

  let l:lineToImport = 0
  if len(l:lines) > 1
    let l:options = ['(abort)'] + l:lines
    let l:userInput = inputlist(map(deepcopy(l:options), { i, x -> i.': '.x }))
    if (l:userInput == 0)
      echo 'aborted.'
      return
    endif
    let l:lineToImport = l:userInput
  endif

  let l:curPos = getpos('.')
  call cursor(2, 1)
  exec 's/\s*/\r/'
  call setline(2, l:lines[l:lineToImport - 1])
  call cursor(l:curPos[1] + 1, l:curPos[2])
endfunction

function! ImportJs#ImportFZF() abort
  let l:search = expand("<cword>")
  if empty(l:search)
    echo '[ImportJs] No search word at current cursor'
    return
  endif
  let l:command = "cat ~/.import-js-list | egrep '\\b".search."\\b'"
  let l:lines = systemlist(command)
  if (len(l:lines) == 0)
    echo '[ImportJs] No match for: '.search
    return
  endif

  " FZF customization
  call fzf#run({
  \  'source':  l:lines,
  \  'sink':    function('s:fzf_callback'),
  \  'options': '-m -x +s --exact',
  \  'down':    '40%'})
endfunction

function! s:fzf_callback(line) abort
  let l:lineToImport = 0
  let l:curPos = getpos('.')
  call cursor(2, 1)
  exec 's/\s*/\r/'
  call setline(2, a:line)
  call cursor(l:curPos[1] + 1, l:curPos[2])
endfunction
