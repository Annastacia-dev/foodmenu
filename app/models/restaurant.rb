# == Schema Information
#
# Table name: restaurants
#
#  id              :uuid             not null, primary key
#  confirmed_at    :datetime
#  email           :string           not null
#  name            :string           not null
#  phone           :string           not null
#  restaurant_type :integer          default("single")
#  slug            :string           not null
#  status          :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Restaurant < ApplicationRecord
  has_paper_trail

  include StatusableModelConcern
  include SluggableModelConcern
  friendly_slug_scope to_slug: :name

  # --- associations ---
  has_many :users, dependent: :destroy
  has_one_attached :logo

  # --- callbacks ---
  before_save :downcase_email
  before_create :send_confirmation_email

  # --- validations ---
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :phone, presence: true
  validate :logo_file_type

  # --- enums ---
  enum restaurant_type: {
    'single_restaurant(one restaurant, one location)': 0,
    'chain_restaurant(one restaurant, multiple locations)': 1,
    'group_restaurant(multiple restaurants, multiple locations)': 2
  }

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

  def send_confirmation_email
    # Send confirmation email
  end

  def create_admin_user
    # Create admin user
  end
end
