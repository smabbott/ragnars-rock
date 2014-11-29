class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :registerable, :recoverable, :database_authenticatable,   
  # devise :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  devise :database_authenticatable, :trackable, :validatable,
    :timeoutable, :omniauthable#, omniauth_providers: [:google_oauth2]
         
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    User.find_by(email: data["email"])
  end
  
end

