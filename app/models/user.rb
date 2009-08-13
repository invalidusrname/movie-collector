class User < TwitterAuth::GenericUser
  include Clearance::User
  include FacebookerAuthentication::Model
  has_many :movies, :through => :users_movies
  has_many :users_movies
  
  # todo: update validations from twitterauth when adding a twitter user
  def utilize_default_validations
    false
  end
end
