class AddFacebookUser < ActiveRecord::Migration
  def self.up
    add_column :users, :facebook_id, :integer
    add_column :users, :session_key, :string

    add_index :users, :facebook_id, :unique => true
  end

  def self.down
    remove_index :users, :facebook_id
    remove_column :users, :facebook_id
    remove_column :users, :session_key

    drop_table :facebook_templates
  end
end
