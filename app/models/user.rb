class User < ApplicationRecord
  
  # adds virtual attributes for authentication
  has_secure_password
  # validates email
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
  
  def admin?
    name == "doom"
  end
  
  def latest_game
    CurrentGame.where(["user_id = ?", self.id]).last
  end
       
end
