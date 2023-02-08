class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         validates :name, :phone, presence: true
         validates :phone, numericality: true
         validates_format_of :name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
         validates :phone,:presence => true,
                 :numericality => true,
                 :length => { :minimum => 10, :maximum => 15 }
                 
    has_one :cart, dependent: :destroy
    has_many :payments, dependent: :destroy
    has_many :orders, dependent: :destroy
    has_many :address, as: :addressable, dependent: :destroy

    validates :email, format: URI::MailTo::EMAIL_REGEXP
    
    def self.authenticate(email, password)
      user = User.find_for_authentication(email: email)
      user&.valid_password?(password) ? user : nil
    end

    

end
