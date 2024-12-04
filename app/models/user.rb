class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true
  has_many :posts, dependent: :destroy

  before_create :generate_authentication_token

  private

  def generate_authentication_token
    self.authentication_token = SecureRandom.hex(16) unless authentication_token.present?
  end
end
