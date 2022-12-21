# frozen_string_literal: true

class CreateBoxOfficeFilms < ActiveRecord::Migration[4.2]
  def self.up
    create_table :box_office_films do |t|
      t.string :title
      t.text :url
      t.float :amount
      t.text :ticket_url
      t.integer :position
      t.date :release_date
      t.integer :duration
      t.timestamps
    end
  end

  def self.down
    drop_table :box_office_films
  end
end
