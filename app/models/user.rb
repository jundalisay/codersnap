require 'carrierwave/orm/activerecord'
require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessor :new_password, :new_password_confirmation, :password, :avatar
	has_secure_password

  #AVATAR
  mount_uploader :avatar, AvatarUploader
  has_many :avatars
  accepts_nested_attributes_for :avatars

  #EMAIL VALIDATIONS
  validates(:username, presence: true)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email,
            presence: true,
            format: { with: VALID_EMAIL_REGEX })
  validates_uniqueness_of :email, case_sensitive: false

  #FRIENDSHIPS
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: :friend_id, dependent: :destroy
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  #MESSAGES
  has_many :sent_messages, class_name: "Message", foreign_key: :sender_id
  has_many :received_messages, class_name: "Message", foreign_key: :recipient_id

  def unread_message_count
    received_messages.where(read: false).count
  end
  
  def self.find_by_identifier(identifier)
    User.where("lower(username) = ?", identifier.downcase).first ||
      User.where("lower(email) = ?", identifier.downcase).first
  end

  def self.purge_unconfirmed(num)
    User.unscoped.where(confirmed: false).where("updated_at < ?", num.days.ago).destroy_all
  end

  #FACEBOOK
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