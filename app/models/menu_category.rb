# == Schema Information
#
# Table name: menu_categories
#
#  id          :uuid             not null, primary key
#  description :string
#  name        :string
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  menu_id     :uuid
#  parent_id   :uuid
#
# Indexes
#
#  index_menu_categories_on_menu_id  (menu_id)
#  index_menu_categories_on_slug     (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (menu_id => menus.id)
#
class MenuCategory < ApplicationRecord
  has_paper_trail
  acts_as_tree order: 'name'

  # --- concerns ---
  include Sluggable
  friendly_slug_scope to_slug: :name

  # --- active storage ---
  has_one_attached :image

  # --- associations ---
  has_many :menu_items, dependent: :destroy

  # --- validations ---
  validates :menu_id, presence: true, if: :is_parent?
  validates :name, presence: true

  def is_parent?
    parent_id.blank?
  end
end
