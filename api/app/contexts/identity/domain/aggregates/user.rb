require 'securerandom'

class User
  def initialize(email, id)
    @email = email
    @id = id
  end

  def email
    @email
  end

  def id
    @id
  end

  private_class_method :new

  def self.create(email, id = SecureRandom.uuid)
    instance = new(email, id)
    return instance
  end
end