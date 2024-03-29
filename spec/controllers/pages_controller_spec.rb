require 'spec_helper'

describe PagesController do
  render_views
  befor(:each) do
    @base_title= "Ruby on Rails Tutorial Sample App"
  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end

    it "returns http success" do
      get 'home'
      response.should have_selector("title",:content => "Ruby on Rails Tutorial Sample | Home" )
  end
	it "should have a non-blank body" do
	get 'home'
	response.body.should_not =~ /<body>\s*<\/body>/
	end
end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
  it "returns http" do
      get 'contact'
      response.should have_selector("title",:content => "Ruby on Rails Tutorial Sample | contacts" )
  end
end
describe "GET 'help' " do
    it "should have the right title" do
      get 'contact'
      response.should be_success
    end
  it "returns http" do
      get 'help'
      response.should have_selector("title",:content => "Ruby on Rails Tutorial Sample | Help" )
  end
end
end
