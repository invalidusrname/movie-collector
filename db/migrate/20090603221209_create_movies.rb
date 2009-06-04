class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :title
      t.string :format
      t.boolean :private
      t.string :asin
      t.references :borrower
      t.references :user

      t.timestamps
    end

    add_index :movies, :borrower_id
    add_index :movies, :user_id
  end

  def self.down
    drop_table :movies
  end
end
