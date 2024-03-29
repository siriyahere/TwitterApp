require 'spec_helper'

describe "LayoutLinks" do
	it "should have a home page at '/' " do
		get '/'
		response.should have_selector('title', :content => "Home")
  
  end
  it "should have a Contact page at '/contact' " do
		get '/contact'
		response.should have_selector('title', :content => "Contact")
  
  end
  it "should have a Help page at '/contact' " do
		get '/help'
		response.should have_selector('title', :content => "Help")
  
  end
  it "should have a SignUp page at '/signup' " do
		get '/signup'
		response.should have_selector('title', :content => "Sign up")
  
  end
  it "should have working links"
  visit root_path
  response.should have_selector('title', :content => "Home")
  end
end