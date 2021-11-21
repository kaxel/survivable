class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # adds virtual attributes for authentication
  #has_secure_password
  # validates email
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
  
  def admin?
    email == "krister.axel@gmail.com"
  end
  
  def latest_game
    CurrentGame.where(["user_id = ?", self.id]).last
  end
       
end
