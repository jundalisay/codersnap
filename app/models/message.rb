class Message < ActiveRecord::Base
  attr_accessor :recipient_identifier

  belongs_to :sender, class_name: "User", foreign_key: :sender_id
  belongs_to :recipient, class_name: "User", foreign_key: :recipient_id
  has_many :sent_messages, foreign_key: "sender_id", class_name: "Message"
  has_many :received_messages, foreign_key: "recipient_id", class_name: "Message"

  validates(:recipient_identifier, presence: true, :if => "recipient_id.nil?")
  validates(:subject, presence: true, length: 1..30)
  validates(:message, presence: true)

  before_save :set_recipient #
  default_scope { order('created_at DESC') }
  
	def read?
		!!read_at
	end
	
	# def sent_messages
	# 	Message.where(sender_id: id)
	# end

	# def received_messages
	# 	Message
	# end

  def remove_user(user)
    self.removed_by_sender = true if user == sender
    self.removed_by_recipient = true if user == recipient
    if removed_by_sender && removed_by_recipient
      self.destroy
    else
      self.save
    end
  end

  def valid_user?(user)
    (sender == user && !removed_by_sender) || (recipient == user && !removed_by_recipient)
  end

private

  def set_recipient
    if recipient_identifier
      recipient = User.find_by_identifier(recipient_identifier)
      self.recipient_id = recipient.try(:id)
    end
    false unless self.recipient_id
  end
end