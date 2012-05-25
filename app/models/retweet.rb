class Retweet < ActiveRecord::Base
	belongs_to :user
	belongs_to :microposts

	scope :retweeted_from , lambda { |user| followed_by(user)}

private
 def self.followed_by (user)
   
   followed_ids = %(SELECT micropost_id FROM  retweets WHERE user_id = :user_id)
  
  Micropost.where("id IN (#{followed_ids})", :user_id => user.id)
 end
end
