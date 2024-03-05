# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  first_name             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  sign_in_count          :integer          default(0), not null
#  slug                   :string
#  status                 :integer          default("active")
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  restaurant_id          :uuid
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_restaurant_id         (restaurant_id)
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (restaurant_id => restaurants.id)
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :trackable
  has_paper_trail

  include Sluggable
  friendly_slug_scope to_slug: :name

  # --- associations ---
  belongs_to :restaurant, optional: true

  # --- callbacks ---
  before_save :downcase_email

  # --- enums ---
  enum role: {
    'super_admin': 'super_admin', # 'super_admin' is not a role in the system, it is used to identify the super admin user
    'admin': 'admin',
    'manager': 'manager',
    'staff': 'staff'
  }

  enum status: {
    'active': 0,
    'inactive': 1
  }

  # --- validations ---
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true
  validates :status, presence: true
  validates :restaurant, presence: true, if: -> { role != 'super_admin' }
  validate :one_admin_per_restaurant

  # --- methods ---
  def name
    "#{first_name} #{last_name}"
  end

  def super_admin?
    role == 'super_admin'
  end

  def restaurant_user?
    role.in?(%w[admin manager staff])
  end

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end

  def one_admin_per_restaurant
    if role == 'admin' && restaurant.users.where(role: 'admin').count > 0
      errors.add(:role, 'cannot have more than one admin')
    end
  end
end
