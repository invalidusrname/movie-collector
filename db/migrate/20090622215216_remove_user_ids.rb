class RemoveUserIds < ActiveRecord::Migration
  def self.up
    remove_column :movies, :user_id
    remove_column :movies, :borrower_id
  end

  def self.down
    add_column :movies, :user_id
    add_column :movies, :borrower_id
  end
end
