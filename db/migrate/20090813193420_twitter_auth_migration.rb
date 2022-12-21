# frozen_string_literal: true

class TwitterAuthMigration < ActiveRecord::Migration
  def self.up
    add_column :users, :twitter_id, :string
    add_column :users, :login, :string
    add_column :users, :access_token, :string
    add_column :users, :access_secret, :string
    add_column :users, :profile_image_url, :string
    add_column :users, :remember_token, :string
    add_column :users, :remember_token_expires_at, :datetime
  end

  def self.down
    remove_column :users, :twitter_id
    remove_column :users, :login
    remove_column :users, :access_secret
    remove_column :users, :access_token
    remove_column :users, :profile_image_url
    remove_column :users, :remember_token
    remove_column :users, :remember_token_expires_at
  end
end
