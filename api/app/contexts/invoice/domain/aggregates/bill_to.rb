class BillTo
  def initialize(info, emails)
    @info = info
    @emails = emails
  end

  def emails
    @emails
  end

  def info
    @info
  end

  private_class_method :new

  def self.create(info, emails)
    some_invalid = emails.any? { |email| true unless email.instance_of? Email }
    raise 'bad argument' if some_invalid == true
    instance = new(info, emails)
    return instance
  end
end