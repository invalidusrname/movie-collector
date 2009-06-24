class AddBorrower < ActiveRecord::Migration
  def self.up
    add_column :users_movies, :borrower_id, :integer
    add_index :users_movies, :borrower_id
  end

  def self.down
    remove_column :users_movies, :borrower_id
  end
end
