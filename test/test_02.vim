

function! s:list_statuses()
  let rest = rubytter#user_timeline('basyura')
  for v in rest
    echo v.user.screen_name . " : " . v.text
  endfor
endfunction

call s:list_statuses()
