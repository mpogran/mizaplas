module SoftDelete
  extend ActiveSupport::Concern

  included do
    default_scope { where(deleted_at: nil) }
    scope :deleted, -> { where.not(deleted_at: nil) }

    define_callbacks :soft_delete

    def soft_deleted?
      deleted_at.present?
    end

    def soft_delete!
      return true if soft_deleted?

      run_callbacks :soft_delete do
        update(deleted_at: Time.current)
      end
    end
  end
end
