
rubytter.vim is a wrapper of rubytter.rb

# dependencies
  - ruby >= 1.9.2
  - the ruby interface to vim

# api

rubytter#request(method , params ...)

# options

- let g:rubytter_consumer_key        = '...'
- let g:rubytter_consumer_secret     = '...'
- let g:rubytter_access_token        = '...'
- let g:rubytter_access_token_secret = '...'

# samples

## friends timeline

let tweets = rubytter#request("friends_timeline")

for v in tweets
  echo v.user.screen_name . ' : ' . v.text
endfor

## list timeline

let tweets = rubytter#request("list_statuses" , "basyura" , "vim")

for v in tweets
  echo v.user.screen_name . ' : ' . v.text
endfor

## update

call rubytter#update("hello rubytter")


# supported API

these API are dependent on rubytter.rb

    # method name             path for API                    http method
    "
      update_status           /statuses/update                post
      remove_status           /statuses/destroy/%s            delete
      public_timeline         /statuses/public_timeline
      home_timeline           /statuses/home_timeline
      friends_timeline        /statuses/friends_timeline
      replies                 /statuses/replies
      mentions                /statuses/mentions
      user_timeline           /statuses/user_timeline/%s
      show                    /statuses/show/%s
      friends                 /statuses/friends/%s
      followers               /statuses/followers/%s
      retweet                 /statuses/retweet/%s            post
      retweets                /statuses/retweets/%s
      retweeted_by_me         /statuses/retweeted_by_me
      retweeted_to_me         /statuses/retweeted_to_me
      retweets_of_me          /statuses/retweets_of_me
      user                    /users/show/%s
      direct_messages         /direct_messages
      sent_direct_messages    /direct_messages/sent
      send_direct_message     /direct_messages/new            post
      remove_direct_message   /direct_messages/destroy/%s     delete
      follow                  /friendships/create/%s          post
      leave                   /friendships/destroy/%s         delete
      friendship_exists       /friendships/exists
      followers_ids           /followers/ids/%s
      friends_ids             /friends/ids/%s
      favorites               /favorites/%s
      favorite                /favorites/create/%s            post
      remove_favorite         /favorites/destroy/%s           delete
      verify_credentials      /account/verify_credentials     get
      end_session             /account/end_session            post
      update_delivery_device  /account/update_delivery_device post
      update_profile_colors   /account/update_profile_colors  post
      limit_status            /account/rate_limit_status
      update_profile          /account/update_profile         post
      enable_notification     /notifications/follow/%s        post
      disable_notification    /notifications/leave/%s         post
      block                   /blocks/create/%s               post
      unblock                 /blocks/destroy/%s              delete
      block_exists            /blocks/exists/%s               get
      blocking                /blocks/blocking                get
      blocking_ids            /blocks/blocking/ids            get
      saved_searches          /saved_searches                 get
      saved_search            /saved_searches/show/%s         get
      create_saved_search     /saved_searches/create          post
      remove_saved_search     /saved_searches/destroy/%s      delete
      create_list             /%s/lists                       post
      update_list             /%s/lists/%s                    put
      delete_list             /%s/lists/%s                    delete
      list                    /%s/lists/%s
      lists                   /%s/lists
      lists_followers         /%s/lists/memberships
      list_statuses           /%s/lists/%s/statuses
      list_members            /%s/%s/members
      add_member_to_list      /%s/%s/members                  post
      remove_member_from_list /%s/%s/members                  delete
      list_following          /%s/%s/subscribers
      follow_list             /%s/%s/subscribers              post
      remove_list             /%s/%s/subscribers              delete
