# frozen_string_literal: true

# Status methods
module Statusable
  extend ActiveSupport::Concern

  included do
    enum status: {
      active: 0,
      inactive: 1,
    }, _suffix: true
  end

  class_methods do
    def active
      where(status: :active)
    end
  end
end