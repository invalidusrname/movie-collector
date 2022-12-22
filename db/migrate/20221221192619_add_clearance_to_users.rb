# frozen_string_literal: true

class AddClearanceToUsers < ActiveRecord::Migration[7.0]
  def self.up
    add_index :users, :confirmation_token, unique: true
    add_index :users, :remember_token, unique: true
  end

  def self.down
    remove_index :users, :confirmation_token, unique: true
    remove_index :users, :remember_token, unique: true
  end
end
