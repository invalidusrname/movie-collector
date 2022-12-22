# frozen_string_literal: true

class CreateGenres < ActiveRecord::Migration[5.0]
  def self.up
    create_table :genres do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :genres
  end
end
