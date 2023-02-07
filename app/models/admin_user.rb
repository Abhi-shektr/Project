class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validate :restrict_to_super_admin, on: [:update,:destroy]
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  def super_admin?
    self.super_admin
  end

  private
  
  def restrict_to_super_admin
    if !super_admin? 
      errors.add(:base, "not allowed")
    end
  end
end
