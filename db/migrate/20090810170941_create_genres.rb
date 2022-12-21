# frozen_string_literal: true

class CreateGenres < ActiveRecord::Migration
  def self.up
    create_table :genres do |t|
      t.string :name
    end

    ['Action',
     'Adult',
     'Adventure',
     'Animation',
     'Biography',
     "Children's",
     'Comedy',
     'Crime',
     'Disaster',
     'Drama',
     'Fantasy',
     'Horror',
     'Musical',
     'Mystery',
     'Romance',
     'Sci-Fi',
     'Short',
     'Sport',
     'Thriller',
     'War',
     'Western'].each { |name| Genre.create(name:) }
  end

  def self.down
    drop_table :genres
  end
end
