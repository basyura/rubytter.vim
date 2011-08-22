

function! s:list_statuses()
  let rest = rubytter#list_statuses('basyura' , 'all')
  for v in rest
    echo v.user.screen_name . ":" . v.text
  endfor
  let rest = rubytter#friends_timeline()
  for v in rest
    echo v.user.screen_name . ":" . v.text
  endfor
endfunction

call s:list_statuses()
