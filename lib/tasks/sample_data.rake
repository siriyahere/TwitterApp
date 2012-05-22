require 'faker'

namespace :db do 
 desc "Fill database with sample data"	
 task :populate => :environment do
 	Rake::Task['db:reset'].invoke
 	User.create!(:name => "AJ",
 				  :email => "aj@gmail.com",
 				  :password => "foobar",
 				  :password_confirmation => "foobar" )
    10.times do |n|
    	name =Faker::Name.name
    	email ="aj-#{n+1}@gmail.com"
    	password = "password"
    	User.create!(:name => name,
    				:email => email,
    				:password => password,
    				:password_confirmation => password)
 end
end
end