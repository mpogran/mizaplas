class ApplicationService
  class Errors < ActiveModel::Errors
    # Skips adding messages
    def add(attribute, message = :invalid, options = {})
      message = message.call if message.respond_to?(:call)
      detail  = normalize_detail(message, options)

      details[attribute.to_sym]  << detail
    end
  end

  class Response
    attr_reader :errors

    def initialize
      @errors = ApplicationService::Errors.new(self)
      @success = false
    end

    def success?
      @success
    end

    def success!
      @success = true
      self # set value and return self
    end
  end

  def self.call(*args)
    new(*args).call
  end

  attr_reader :response

  def initialize(*)
    @response = Response.new
  end

  def call
    raise NotImplementedError
  end
end
