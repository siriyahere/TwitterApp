class User < ActiveRecord::Base
  attr_accessor :password
 # extend FriendlyId
  has_many :microposts,   :dependent => :destroy
  has_many :relationships,:dependent => :destroy,
                          :foreign_key => "follower_id"
   has_many :reverse_relationships,
                          :foreign_key => "followed_id",
                          :class_name => "Relationship" ,
                          :dependent => :destroy         
  has_many :following, :through => :relationships, :source => :followed
  has_many :followers, :through => :reverse_relationships, :source => :follower
  attr_accessible  :name, :email ,:password ,:password_confirmation
  #friendly_id :name
  email_regex= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name ,:presence => true, :length => {:maximum => 50 }
  validates :email ,:presence => true , :uniqueness => { :case_sensitive => false },
  					:format => { :with => email_regex }
  validates :password, :presence => true,
  						:confirmation => true,					
  						:length => { :within => 6..40 }
   
   before_save:encrypt_password
   
  # scope :admin, where(:admin => true)


   def has_password?(submitted_password)
   		encrypted_password == encrypt(submitted_password)
   end
  def feed
     # Micropost.where("user_id = ?", id)
     Micropost.from_users_followed_by(self)

  end
  def following?(followed)
      relationships.find_by_followed_id(followed)
  end 
  def follow!(followed)
      relationships.create!(:followed_id =>followed.id)
  end 
  def unfollow!(followed)
      relationships.find_by_followed_id(followed).destroy
  end 
  class << self 
  	
  
   def authenticate(email,submitted_password)
   		user = find_by_email(email)
   		return nil if user.nil?
   		return user if user.has_password?(submitted_password)
   end  
   def authenticate_with_salt(id,cookie_salt)
      user=find_by_id(id)
      (user && user.salt == cookie_salt) ? user :nil       
  end
end
   private 

   def encrypt_password
   		self.salt=make_salt if new_record?
   		self.encrypted_password=encrypt(password)

   end
   
   def encrypt(string)
   		secure_hash("#{salt}--#{string}") #TODO
   end
   
   def make_salt
   	secure_hash("#{Time.now.utc}--#{password}")
   end
   
   def secure_hash(string)
   	Digest::SHA2.hexdigest(string)
   end

end
