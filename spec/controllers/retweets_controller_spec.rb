require 'spec_helper'

describe RetweetsController do

  describe "GET 'retweet'" do
    it "returns http success" do
      get 'retweet'
      response.should be_success
    end
  end

end
