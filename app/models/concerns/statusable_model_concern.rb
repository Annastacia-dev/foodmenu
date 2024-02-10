# frozen_string_literal: true

# Status methods
module StatusableModelConcern
  extend ActiveSupport::Concern

  included do
    enum status: {
      inactive: 0,
      active: 1,
    }, _suffix: true
  end

  class_methods do
    def active
      where(status: :active)
    end
  end
end