class User < ActiveRecord::Base
	has_secure_password

  mount_uploader :avatar, AvatarUploader
  has_many :avatars
  accepts_nested_attributes_for :avatars

  validates(:username, presence: true)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email,
            presence: true,
            format: { with: VALID_EMAIL_REGEX })
  validates_uniqueness_of :email, case_sensitive: false

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end