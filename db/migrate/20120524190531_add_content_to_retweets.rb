class AddContentToRetweets < ActiveRecord::Migration
  def self.up
    add_column :retweets, :content, :string
  end

  def self.down
    remove_column :retweets, :content
  end
end
