# frozen_string_literal: true

class AddUpcToMovies < ActiveRecord::Migration
  def self.up
    add_column :movies, :upc, :string
  end

  def self.down
    remove_column :movies, :upc
  end
end
