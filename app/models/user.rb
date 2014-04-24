class User < ActiveRecord::Base
  attr_reader :password
  before_validation :ensure_session_token
  validates :email, :password_digest, :username, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :email, :username, uniqueness: true
  has_many(
  :posted_ads,
  class_name: 'Ad',
  foreign_key: :submitter_id,
  inverse_of: :submitter, dependent: :destroy)

  has_many(
  :authored_responses,
  class_name: 'Response',
  foreign_key: :respondent_id,
  inverse_of: :author,
  dependent: :destroy
  )

  has_many(
  :post_response_notifications,
   through: :posted_ads,
    source: :response_notifications)

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    user.try(:is_password?, password) ? user : nil
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def password=(unencrypted_password)
    @password = unencrypted_password
    self.password_digest = BCrypt::Password.create(unencrypted_password)
  end

  def is_password?(attempted_password)
    BCrypt::Password.new(self.password_digest).is_password?(attempted_password)
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end


end
