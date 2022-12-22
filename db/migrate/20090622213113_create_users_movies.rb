# frozen_string_literal: true

class CreateUsersMovies < ActiveRecord::Migration[4.2]
  def self.up
    create_table :users_movies do |t|
      t.integer :user_id
      t.integer :movie_id
      t.integer :rating
      t.timestamps
    end

    add_index :users_movies, :user_id
    add_index :users_movies, :movie_id
  end

  def self.down
    drop_table :users_movies
  end
end
