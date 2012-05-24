class AddAuthIdToMicroposts < ActiveRecord::Migration
  def self.up
    add_column :microposts, :auth_id, :integer
  end

  def self.down
    remove_column :microposts, :auth_id
  end
end
