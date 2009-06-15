class AddImageToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :image, :text
    add_column :movies, :image_link, :text
    add_column :movies, :thumbnail, :text
  end

  def self.down
    remove_column :movies, :image
    remove_column :movies, :image_link
    remove_column :movies, :thumbnail
  end
end
