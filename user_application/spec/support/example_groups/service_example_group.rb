module ServiceExampleGroup
  extend ActiveSupport::Concern

  RSpec.configure do |config|
    config.include(self, type: :service)
  end


  def call(*args)
    described_class.call(*args)
  end
end
