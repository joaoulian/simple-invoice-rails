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
    instance = new(info, emails)
    return instance
  end
end