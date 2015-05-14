class User < ActiveRecord::Base
  validates :email, :password, :session_token, presence: true
  validates :email, :session_token, uniqueness: true

  after_initialize :ensure_session_token

  def self.find_by_credentials(email, password)
    user = self.find_by(email: email)
    user if user.passwords_match?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    save!
    session_token
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def passwords_match?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
end
