class UsersMovie < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user
  belongs_to :borrower, :class_name => "User", :foreign_key => "borrower_id"
  
  def loan_movie_to(user)
    self.borrower = user
  end

  def return_movie
    self.borrower = nil
  end
end
