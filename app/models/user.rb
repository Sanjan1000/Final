class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { standard: 0, admin: 1 }

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :posts

  before_create :generate_api_token

  def generate_api_token
    self.api_token = SecureRandom.hex(20)
  end

  # Allow regenerating token if needed
  def regenerate_api_token
    update(api_token: SecureRandom.hex(20))
  end

  # Check if the user is active for authentication (not blocked)
  def active_for_authentication?
    super && !blocked?
  end

  # Custom message for blocked users
  def inactive_message
    !blocked? ? super : :blocked
  end
end
