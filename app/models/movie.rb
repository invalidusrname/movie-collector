class Movie < ActiveRecord::Base
  belongs_to :user
  belongs_to :borrower, :class_name => "User", :foreign_key => "borrower_id"
  validates_presence_of :title
  validates_presence_of :format
end
