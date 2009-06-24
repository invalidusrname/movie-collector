class AddGenreAndYearToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :release_date, :date
    add_column :movies, :genre, :string
  end

  def self.down
    remove_column :movies, :genre
    remove_column :movies, :release_date
  end
end
