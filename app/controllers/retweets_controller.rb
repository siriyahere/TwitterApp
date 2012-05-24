class RetweetsController < ApplicationController
  def retweet
  		 #raise params.inspect
			micropost =Micropost.find(params[:micropost][:id])
			#@micropost =current_user.microposts.find(params[:id])
			#redirect_to root_path
			@new_retweet=current_user.retweets.build(micropost_id: micropost.id , author_id: micropost.user_id , user_id: current_user.id)
			#@new_retweet=current_user.microposts.build(user_id: content: micropost.content)
			#new_retweet = @current_user.retweets.build(micropost_id: micropost.id , author_id: micropost.user_id)
			#@micropost.save
			if @new_retweet.save
				redirect_to root_path, :flash => { :success => "Successfully retweeted"}
			else
				redirect_to root_path, :flash => { :success => "retweet failed"}
			end
		end

end
