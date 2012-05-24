class RetweetController < ApplicationController
	def retweet
			#@micropost = micropost.content
			micropost = Micropost.find(params[:id])
			if @micropost.save
				redirect_to root_path, :flash => { :success => "Successfully retweeted"}
			else
				redirect_to root_path, :flash => { :success => "retweet failed"}
			end
		end
end
