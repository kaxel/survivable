class User < ApplicationRecord
  has_many :survivalists
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # adds virtual attributes for authentication
  #has_secure_password
  # validates email
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
  
  def admin?
    ["talk@digbox.net"].include? email
  end
  
  def latest_game
    CurrentGame.where(["user_id = ?", self.id]).last
  end
  
  def current_admin
    current_user && current_user.is_admin
  end
       
end
