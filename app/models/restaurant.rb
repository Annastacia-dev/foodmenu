# == Schema Information
#
# Table name: restaurants
#
#  id              :uuid             not null, primary key
#  confirmed       :boolean          default(FALSE)
#  confirmed_at    :datetime
#  currency        :string           default("KES")
#  email           :string           not null
#  name            :string           not null
#  phone           :string           not null
#  restaurant_type :integer          default("single_restaurant(one restaurant, one location)")
#  sample          :boolean          default(FALSE)
#  slug            :string           not null
#  status          :integer          default("inactive")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  layout_id       :uuid
#
# Indexes
#
#  index_restaurants_on_layout_id  (layout_id)
#
# Foreign Keys
#
#  fk_rails_...  (layout_id => layouts.id)
#

class Restaurant < ApplicationRecord
  has_paper_trail

  include Statusable
  include Sluggable
  friendly_slug_scope to_slug: :name

  # --- associations ---
  belongs_to :layout, optional: true
  has_many :users, dependent: :destroy
  has_one_attached :logo, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :sub_restaurants, dependent: :destroy
  has_many :menu_categories, through: :menus, dependent: :destroy
  has_many :menu_items, through: :menu_categories, dependent: :destroy
  has_one :location_single, class_name: 'Location', foreign_key: 'locatable_id', dependent: :destroy
  has_many :locations_chain, class_name: 'Location', foreign_key: 'locatable_id', dependent: :destroy

  # --- callbacks ---
  before_save :downcase_email

  # --- validations ---
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :phone, presence: true, uniqueness: { message: 'has already been taken' }, format: { with: /\A\+?[0-9]{10,15}\z/, message: 'must be a valid phone number' }
  validate :logo_file_type

  # --- enums ---
  enum restaurant_type: {
    'single_restaurant(one restaurant, one location)': 0,
    'chain_restaurant(one restaurant, multiple locations)': 1,
    'group_restaurant(multiple restaurants, multiple locations)': 2
  }

  def confirmed?
    confirmed_at.present?
  end

  def active?
    status == 'active'
  end

  def single?
    restaurant_type == 'single_restaurant(one restaurant, one location)'
  end

  def chain?
    restaurant_type == 'chain_restaurant(one restaurant, multiple locations)'
  end

  def group?
    restaurant_type == 'group_restaurant(multiple restaurants, multiple locations)'
  end

  def has_an_admin?
    users.where(role: :admin).exists?
  end

  def location
   ( self.single? || self.group? ) ? location_single : nil
  end

  def locations
    chain? ? locations_chain : nil
  end

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end

  def logo_file_type
    return unless logo.attached?

    unless logo.content_type.in?(%w[image/jpeg image/png])
      errors.add(:logo, 'must be a JPEG or PNG file')
    end
  end
end
