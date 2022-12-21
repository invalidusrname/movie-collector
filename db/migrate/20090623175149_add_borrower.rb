# frozen_string_literal: true

class AddBorrower < ActiveRecord::Migration[4.2]
  def self.up
    add_column :users_movies, :borrower_id, :integer
    add_index :users_movies, :borrower_id
  end

  def self.down
    remove_column :users_movies, :borrower_id
  end
end
