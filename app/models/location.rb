# == Schema Information
#
# Table name: locations
#
#  id               :uuid             not null, primary key
#  area             :string           not null
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
#  slug             :string
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
  include Statusable
  include Sluggable
  friendly_slug_scope to_slug: :location_name

  # --associations--
  belongs_to :locatable, polymorphic: true

  # ---callbacks---
  before_save :geocode_location

  # --validations--
  validates :country, presence: true
  validates :nearest_landmark, presence: true

  # --scopes--

  # --class methods--

  # --instance methods--

  def location_name
    "#{building_name}, #{area}, #{city}"
  end

  private

  def geocode_location
    return unless country_changed? || city_changed? || area_changed?

    geocode = Geocoder.search("#{country}, #{city}, #{area}").first
    return unless geocode

    self.latitude = geocode.latitude
    self.longitude = geocode.longitude
  end
end
