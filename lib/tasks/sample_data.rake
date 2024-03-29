require 'faker'

namespace :db do 
 desc "Fill database with sample data"	
 task :populate => :environment do
 	Rake::Task['db:reset'].invoke
 	admin=User.create!(:name => "AJ",
 				  :email => "aj@gmail.com",
 				  :password => "foobar",
 				  :password_confirmation => "foobar" )
    admin.toggle!(:admin)
    10.times do |n|
    	name =Faker::Name.name
    	email ="aj-#{n+1}@gmail.com"
    	password = "password"
    	User.create!(:name => name,
    				:email => email,
    				:password => password,
    				:password_confirmation => password)
 end
 User.all( :limit => 3).each do |user|
 	50.times do user.microposts.create!(:content => Faker::Lorem.sentence(5))
end
end
end
end