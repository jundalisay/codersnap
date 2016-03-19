class SessionForm
  include ActiveModel::Model
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :email, :password

  validates_presence_of :email, :password

  def persisted?
    false
  end

end