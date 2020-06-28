class ApplicationService
  include ActiveModel::Model

  def self.class(*args)
    new(*args).call
  end

  # Required for ActiveModel::Errors
  def self.human_attribute_name(attr, options = {})
    attr
  end

  def self.lookup_ancestors
    [self]
  end

  attr_reader :errors, :observers

  def initialize(*args)
    super

    @errors = ActiveModel::Errors.new(self)
  end


  def call
    raise NotImplementedError
  end

  # Required for ActiveModel::Errors
  def read_attribute_for_validation(attr)
    send(attr)
  end
end
