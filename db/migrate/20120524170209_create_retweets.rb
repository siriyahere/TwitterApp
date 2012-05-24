class CreateRetweets < ActiveRecord::Migration
  def self.up
    create_table :retweets do |t|
      t.string :user_id
      t.integer :author_id
      t.integer :micropost_id

      t.timestamps
    end
  end

  def self.down
    drop_table :retweets
  end
end
