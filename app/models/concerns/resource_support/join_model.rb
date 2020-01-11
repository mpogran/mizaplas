module ResourceSupport::JoinModel
  extend ActiveSupport::Concern

  included do
    scope :owned, -> { where(owner: true) }
    scope :unowned, -> { where(owner: false) }
    scope :favorite, -> { where(favorite: false) }
  end
end

