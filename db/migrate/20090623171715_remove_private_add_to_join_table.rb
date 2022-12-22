# frozen_string_literal: true

class RemovePrivateAddToJoinTable < ActiveRecord::Migration[4.2]
  def self.up
    remove_column :movies, :private
    add_column :users_movies, :private, :boolean
  end

  def self.down
    remove_column :users_movies, :private
    add_column :movies, :private, :boolean
  end
end
