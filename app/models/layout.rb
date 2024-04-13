# == Schema Information
#
# Table name: layouts
#
#  id          :uuid             not null, primary key
#  description :text             not null
#  name        :string           not null
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_layouts_on_slug  (slug) UNIQUE
#
class Layout < ApplicationRecord
  has_paper_trail

  include Sluggable
  friendly_slug_scope to_slug: :name

  # --- associations ---
  has_many :restaurants, dependent: :nullify
  has_many :sub_restaurants, dependent: :nullify
  has_one_attached :image

  # --- callbacks ---
  before_save :downcase_name

  # --- validations ---
  validates :description, presence: true
  validates :name, presence: true

  # --- instance methods ---

  # --- private methods ---
  def downcase_name
    self.name = self.name.downcase
  end
end
