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
#  menu_id     :uuid             not null
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
  acts_as_tree order: "name"

  # --concerns--
  include SluggableModelConcern
  friendly_slug_scope to_slug: :name

  # --associations--
  belongs_to :menu
  has_many :menu_items, dependent: :destroy

  # --validations--
  validates :name, presence: true
end
