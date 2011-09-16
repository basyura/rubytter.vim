" this file's path
let s:script_path = expand("<sfile>:p:h")
ruby << EOF
  require VIM.evaluate('s:script_path') + '/ruvitter'
EOF
"
"
let s:rubytter = {'request' : function('rubytter#request')}
"
"
function! s:rubytter.request(method, ...)
  return call('s:request' , [self.config , a:method] + a:000)
endfunction
"
"
function! rubytter#new(config)
  let rubytter = copy(s:rubytter)
  let rubytter.config = a:config
  return rubytter
endfunction
"
"
function! rubytter#request(method, ...)
  let config = {
        \ 'consumer_key'        : g:rubytter_consumer_key ,
        \ 'consumer_secret'     : g:rubytter_consumer_secret ,
        \ 'access_token'        : g:rubytter_access_token ,
        \ 'access_token_secret' : g:rubytter_access_token_secret ,
        \ }

  return call('s:request' , [config , a:method] + a:000)
endfunction
"
"
function! s:request(config, method, ... )
  echoerr
ruby << EOF
  consumer_key        = VIM.evaluate('a:config.consumer_key')
  consumer_secret     = VIM.evaluate('a:config.consumer_secret')
  access_token        = VIM.evaluate('a:config.access_token')
  access_token_secret = VIM.evaluate('a:config.access_token_secret')
  client = Ruvitter.new({
    :consumer_key        => consumer_key    ,
    :consumer_secret     => consumer_secret ,
    :access_token        => access_token    ,
    :access_token_secret => access_token_secret
  })
  method = VIM.evaluate("a:method")
  args   = VIM.evaluate("a:000")
  if args.length == 1 && args[0].kind_of?(Array)
    args = args[0]
  end
  result = client.__send__(method , *args)
  VIM.command("let result = #{result}")
EOF
  return result
endfunction

