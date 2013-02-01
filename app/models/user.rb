class User < ActiveRecord::Base
  # Include default users modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :name, :remember_me
  has_many :posts, :dependent => :destroy
  validates :email, presence: true
  validates :password, presence: true ,length: { minimum: 6 }

  #finding user if already sign up using google account otherwise will create new one
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = where(:email => data["email"]).first

    unless user
      user = create(name: data["name"],
                         email: data["email"],
                         password: Devise.friendly_token[0,20]
      )
    end
    user
  end
end
