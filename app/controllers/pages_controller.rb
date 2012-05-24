class PagesController < ApplicationController
  def home
  	@title= "Home"
  	if signed_in?
  		@micropost= Micropost.new 
  		@feed_items =current_user.feed.sort{|x,y| y.created_at <=> x.created_at}.paginate(:page => params[:page])
  		#@feed_items = current_user.feed.paginate(:page => params[:page])

  	end
  end
  def contact
@title = "contacts"
end
 
 def help
@title = "help"
  end

end
