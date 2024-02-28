# == Schema Information
#
# Table name: locations
#
#  id               :uuid             not null, primary key
#  building_name    :string
#  city             :string
#  country          :string           not null
#  county           :string
#  extra_directions :string
#  floor_number     :string
#  latitude         :decimal(10, 6)
#  locatable_type   :string
#  longitude        :decimal(10, 6)
#  nearest_landmark :string           not null
#  postal_code      :string
#  state            :string
#  status           :integer          default("active")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  locatable_id     :uuid
#
# Indexes
#
#  index_locations_on_locatable  (locatable_type,locatable_id)
#
class Location < ApplicationRecord
  has_paper_trail

  # --concerns--
  include StatusableModelConcern

  # --associations--
  belongs_to :locatable, polymorphic: true

  # --validations--
  validates :country, presence: true
  validates :nearest_landmark, presence: true
end
