# == Schema Information
#
# Table name: sub_restaurants
#
#  id            :uuid             not null, primary key
#  description   :text
#  email         :string
#  name          :string           not null
#  phone_number  :string
#  slug          :string           not null
#  status        :integer          default("active")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  layout_id     :uuid
#  restaurant_id :uuid             not null
#
# Indexes
#
#  index_sub_restaurants_on_layout_id      (layout_id)
#  index_sub_restaurants_on_restaurant_id  (restaurant_id)
#
# Foreign Keys
#
#  fk_rails_...  (layout_id => layouts.id)
#  fk_rails_...  (restaurant_id => restaurants.id)
#
class SubRestaurant < ApplicationRecord
  has_paper_trail

  include Sluggable
  include Statusable
  friendly_slug_scope to_slug: :name

  # --- active storage attachments ---
  has_one_attached :logo

  # --- associations ---
  belongs_to :restaurant
  belongs_to :layout, optional: true
  has_many :menus, dependent: :destroy
  has_many :menu_categories, through: :menus, dependent: :destroy
  has_many :locations, as: :locatable, dependent: :destroy

  # --- validations ---
  validates :name, presence: true, uniqueness: { scope: :restaurant_id }
  validates :restaurant_id, presence: true
  validates :phone_number, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
