class Message < ActiveRecord::Base

  belongs_to :sender, class_name: "User", foreign_key: :sender_id
  belongs_to :recipient, class_name: "User", foreign_key: :recipient_id
  has_many :sent_messages, foreign_key: "sender_id", class_name: "Message"

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
end
