require 'rubytter'
require 'yaml'

class Ruvitter
  #
  #
  def initialize
    config   = Ruvitter::Config.new("/repos/ruby/tweet_crawler/config.yaml")
    consumer = OAuth::Consumer.new(
      config.consumer_key     ,
      config.consumer_secret ,
      :site => 'https://api.twitter.com'
    )
    access_token = OAuth::AccessToken.new(
      consumer ,
      config.access_token ,
      config.access_token_secret
    )
    @client = OAuthRubytter.new(access_token)
  end
  #
  #
  def respond_to?(method)
    @client.respond_to?(method)
  end
  #
  #
  def method_missing(method , *args)
    parse(@client.__send__(method , *args))
  end
  #
  #
  def parse(tweets)
    buf = "["
    first = true
    tweets.each do |tweet|
      if first
        first = false
      else
        buf << ","
      end
      buf << parse_tweet(tweet)
    end
    buf << "]"
    buf
  end
  #
  #
  def parse_tweet(tweet)
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
        buf << parse_tweet(value)
      else
        buf << "'"
        buf << value.to_s.gsub("" , "").gsub("\n","").gsub("'" , "''")
        #buf << value.to_s.gsub("" , "").gsub("'" , "''")
        buf << "'"
      end
    end
    buf << "}"
    buf
  end
  #
  #
  #
  class Config
    DEFAULT_IMAGES_DIR       = File.expand_path("~/.tweecle/images")
    DEFAULT_PSTORE_PATH      = File.expand_path("~/.tweecle")
    DEFAULT_NOTIFY_NUMBER    = 3
    DEFAULT_SLEEPING_SECONDS = 11
    TO_INT_METHODS = [:notify_number , :sleeping_seconds]
    #
    #
    def initialize(config_path)
      @config = YAML.load(open(config_path).read)
    end
    #
    #
    def pstore_path(name)
      File.join(method_missing("pstore_path"), "#{name}.pstore")
    end
    #
    #
    def method_missing(method , *args)
      value = @config[method.to_s]
      unless value
        begin
          value = self.class.const_get("DEFAULT_" + method.to_s.upcase)
        rescue NameError => e
          raise StandardError("No Such Config : #{method}")
        end
      end
      TO_INT_METHODS.include?(method) ? value.to_i : value
    end
  end
end
