require 'rubytter'

class Ruvitter
  #
  #
  def initialize(config)
    proxy = system_proxy
    # create consumer
    consumer = OAuth::Consumer.new(
      config[:consumer_key]    ,
      config[:consumer_secret] ,
      {
        :site  => 'https://api.twitter.com' ,
        :proxy => proxy ,
      }
    )
    # create token
    access_token = OAuth::AccessToken.new(
      consumer ,
      config[:access_token] ,
      config[:access_token_secret]
    )
    # create rubytter
    option = {}
    option.merge(:proxy_host => proxy.host , :proxy_port => proxy.port) if proxy
    @client = OAuthRubytter.new(access_token , option)
  end
  #
  #
  def method_missing(method , *args)
    parse(@client.__send__(method , *args))
  end

  private
  #
  #
  def parse(tweets)
    return parse_hash(tweets) if tweets.kind_of? Hash
    buf = "["
    tweets.each_with_index do |tweet , index|
      buf << "," if index != 0
      buf << parse_hash(tweet)
    end
    buf << "]"
  end
  #
  #
  def parse_hash(tweet)
    buf = "{"
    first = true
    tweet.each_pair do |key , value|
      if first
        first = false
      else
        buf << ","
      end
      buf << "'#{key}' : "
      if value.kind_of?(Hash) 
        buf << parse_hash(value)
      else
        buf << "'"
        buf << value.to_s.gsub("" , "").gsub("\n","").gsub("'" , "''")
        buf << "'"
      end
    end
    buf << "}"
  end
  #
  #
  def system_proxy
    proxy = ENV["https_proxy"] || ENV["http_proxy"]
    if proxy
      return proxy =~ /^http.*/ ? URI.parse(proxy) : URI.parse("https://#{proxy}")
    end
    nil
  end
end
