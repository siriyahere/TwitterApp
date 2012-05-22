class PagesController < ApplicationController
  def home
  @micropost= Micropost.new if signed_in?
  end

  def contact
@title = "contacts"
end
 
 def help
@title = "help"
  end

end
