class Micropost < ActiveRecord::Base
attr_accessible  :content
belongs_to :user
has_many :retweets                         
validates :content, :presence => true , :length => { :maximum => 140 }
validates :user_id, :presence => true
default_scope :order => 'microposts.created_at DESC'
named_scope :ordered, :order => 'microposts.created_at DESC'
scope :from_users_followed_by, lambda { |user| followed_by(user)}
scope :retweeted_from , lambda { |user| retweed_by(user)}
private
 def self.followed_by (user)
   followed_ids = %(SELECT followed_id FROM relationships WHERE follower_id = :user_id)
where("user_id IN (#{followed_ids}) OR user_id = :user_id",:user_id => user) 	
 #end
 end

 def self.retweed_by(user)
 	followed_ids = %(SELECT micropost_id FROM  retweets WHERE user_id = :user_id)
where("id IN (#{followed_ids})", :user_id => user.id)
 end

#def self.from_users_followed_by(user)
#followed_ids = user.following.map(& :id).join(" , ")
#where("user_id IN (#{followed_ids}) OR user_id = ?" , user ) 	
#end
end

#user.following.map(& :id).join(" , ")