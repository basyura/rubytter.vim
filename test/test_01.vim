

function! s:list_statuses()
  "let rest = rubytter#mentions()
  "for v in rest
    "echo v.user.screen_name . ":" . v.text
  "endfor
  let rest = rubytter#list_statuses('basyura' , 'vim')
  for v in rest
    echo v.user.screen_name . " : " . v.text
  endfor
  "let tweets = rubytter#friends_timeline()
  "for t in tweets
    "echo t.user.screen_name . " : " . t.text
  "endfor
endfunction

call s:list_statuses()
