
require '../../autoload/ruvitter'

describe Ruvitter, "parse Hash" do
  before do
    @client = Ruvitter.new({
      :consumer_key        => "",
      :consumer_secret     => "",
      :access_token        => "",
      :access_token_secret => "" 
    })
  end
  it "should hash to vim's dict" do
    ret = @client.__send__(:parse_hash , {:screen_name => 'vimmer'})
    ret.should == "{'screen_name' : 'vimmer'}"
  end
  it "should hash to vim's dict" do
    ret = @client.__send__(:parse_hash , {:screen_name => 'vimmer' , :text => 'hello'})
    ret.should == "{'screen_name' : 'vimmer','text' : 'hello'}"
  end
  it "should escape single quote" do
    ret = @client.__send__(:parse_hash , {:screen_name => 'v\'immer'})
    ret.should == "{'screen_name' : 'v''immer'}"
  end

  it "should list to vim's list" do
    ret = @client.__send__(:parse , [{:screen_name => 'vimmer'}])
    ret.should == "[{'screen_name' : 'vimmer'}]"
  end
  it "should list to vim's list" do
    ret = @client.__send__(:parse , [
      {:screen_name => 'vimmer'},{:screen_name => 'rubyist'}
    ])
    ret.should == "[{'screen_name' : 'vimmer'},{'screen_name' : 'rubyist'}]"
  end
end
