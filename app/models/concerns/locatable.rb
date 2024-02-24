# frozen_string_literal: true

module Locatable
  extend ActiveSupport::Concern

  included do
    # --associations--
    belongs_to :locatable, polymorphic: true

    # --validations--
    validates :country, presence: true
    validates :nearest_landmark, presence: true
  end

end