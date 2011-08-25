" this file's path
let s:script_path = expand("<sfile>:p:h") 
ruby << EOF
  require VIM.evaluate('s:script_path') + '/ruvitter'
  consumer_key        = VIM.evaluate('g:rubytter_consumer_key')
  consumer_secret     = VIM.evaluate('g:rubytter_consumer_secret')
  access_token        = VIM.evaluate('g:rubytter_access_token')
  access_token_secret = VIM.evaluate('g:rubytter_access_token_secret')
  @client = Ruvitter.new({
    :consumer_key        => consumer_key    ,
    :consumer_secret     => consumer_secret ,
    :access_token        => access_token    ,
    :access_token_secret => access_token_secret
  })
EOF
"
"
function! rubytter#request(method, ...)
ruby << EOF
  method = VIM.evaluate("a:method")
  args   = VIM.evaluate("a:000")
  if args.length == 1 && args[0].kind_of?(Array)
    args = args[0]
  end
  result = @client.__send__(method , *args)
  VIM.command("let result = #{result}")
EOF
  return result
endfunction
