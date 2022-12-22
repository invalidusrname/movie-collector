# frozen_string_literal: true

class AddConfirmationTokenToUser < ActiveRecord::Migration[4.2]
  def self.up
    add_column :users, :confirmation_token, :string
  end

  def self.down
    remove_column :users, :confirmation_token
  end
end
