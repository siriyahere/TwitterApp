require 'spec_helper'

describe User do

	before(:each) do
		@attr= { :name => "Sample" , :email => "user@sample.com", :password=>"foobar", :password_confirmation => "foobar"}

 # pending "add some examples to (or delete) #{__FILE__}"
 it "new instance shud be created" do
 User.create!(@attr)
end
 it "shud hv a name" do
 	no_name_user=User.new(@attr.merge(:name=>""))
    no_name_user.should_not_be_valid
end
it "shud hv an email" do
 	no_mail_user=User.new(:name => "sample")
    no_mail_user.should_not_be_valid
end
it "shud reject long names"
long_name = "a" * 51
long_name_user=User.new(@attr.merge(:name => long_name))
long_name_user.should_not_be_valid
end
it "should accept valid e-mail" do
	address=%w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
	address.each do |address|
		valid_email_user = User.new(@attr.merge(:email => address))
   	    valid_email_user.should be_valid 
    end
end
it "should reject valid e-mail" do
	address=%w[user@foo,com THE_USER_foo.bar.org first.last@foo.]
	address.each do |address|
		invalid_email_user = User.new(@attr.merge(:email => address))
   	    invalid_email_user.should_not be_valid 
    end
end
it "shud reject dupl. address" do
	User.create!(@attr)
	user_with_dupl=User.new(@attr)
	user_with_dupl.should_not be_valid
end
it "shud reject upto case" do
	upcased="USER@SAMPLE>COM"
	User.create!(@attr.merge(:email => upcased))
    user_with_dupl=User.new(@attr)	
    	user_with_dupl.should_not be_valid
    end

    describe "passwords" do
       before (:each) do
       	@user= User.new(@attr)
       end
    	it "should have pwd attribute" do
    		@user.should respond_to(:password)
		end
		it "should have pwd confirmation attribute" do
    		@user.should respond_to(:password_confirmation)
		end		
    end
    describe "password validations" do
    	it "shud require a pwd" do
    		User.new(@attr.merge(:password=> "", :password_confirmation => "")).should_not_be_valid
    	end
    	it "shud require a matching pwd" do
    		User.new(@attr.merge(:password_confirmation=> "invalid")).should_not_be_valid
    	end
     
     	it "should reject short passwords" do
     	    short ="abcde" 
     	    hash=@attr.merge(:password => short,:password_confirmation=>short)
 			User.new(hash).should_not be_valid
 		end 
 		it "should reject long passwords" do
     	    short ="a"*41 
     	    hash=@attr.merge(:password => short,:password_confirmation=>short)
 			User.new(hash).should_not be_valid
 		end   

    end
    describe "password encryption" do
    	before(:each) do
    		@user=User.create!(@attr)
    	end
    	it "should have an encrypted pwd  attribute" do
    		@user.should respond_to(:encrypted_password)
		end		
		it "should set the encrypted pwd" do
			@user.encrypted_password.should_not be_blank
		end
		it "should have a salt" do
			@user.should respond_to(:salt)
		end
		describe "has_password?method " do
			it "should exist" do
				@user.should respond_to(:has_password?)
			end
			it "shud return true if pwd match" do
				@user.has_password(@attr[:password]).should be_true
			end	

		end
		describe "authenticate method " do
			it "shud exist " do
				User.should respond_to(:authenticate)
		end
			it "shud return nil on email/pwd mismatch" do
			User.authenticate(@attr[:email],"wrongpass").should be_nil
			end
			it "shud return nil for an email with no user" do
			 User.authenticate("bar@foo.com",@attr[:password]).should be_nil 
			end
			it "shud return the user on match"	do
			User.authenticate(@attr[:email],@attr[:password]).should == @user	
			end
		end
	end
end
