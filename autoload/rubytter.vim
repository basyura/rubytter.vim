" this file's path
let s:script_path = expand("<sfile>:p:h") 
ruby << EOF
  require VIM.evaluate('s:script_path') + '/ruvitter'
  @client = Ruvitter.new
EOF
"
"
"
function! rubytter#list_statuses(user, list)
ruby << EOF
  text = @client.list_statuses(
    VIM.evaluate('a:user') ,
    VIM.evaluate('a:list') ,
  )
  VIM.command("let tweets=#{text}")
EOF
  return tweets
endfunction
"
"
"
function! rubytter#friends_timeline()
ruby << EOF
  text = @client.friends_timeline
  VIM.command("let tweets=#{text}")
EOF
  return tweets
endfunction
