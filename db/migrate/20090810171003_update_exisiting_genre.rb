# frozen_string_literal: true

class UpdateExisitingGenre < ActiveRecord::Migration[4.2]
  def self.up
    remove_column :movies, :genre
    add_column :movies, :genre_id, :integer
    add_index :movies, :genre_id
  end

  def self.down
    remove_column :movies, :genre_id
    add_column :movies, :genre, :string
  end
end
