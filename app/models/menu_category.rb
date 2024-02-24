# == Schema Information
#
# Table name: menu_categories
#
#  id          :uuid             not null, primary key
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  menu_id     :uuid             not null
#
# Indexes
#
#  index_menu_categories_on_menu_id  (menu_id)
#
# Foreign Keys
#
#  fk_rails_...  (menu_id => menus.id)
#
class MenuCategory < ApplicationRecord
  has_paper_trail
  acts_as_tree order: "name"

  # --concerns--

  # --associations--
  belongs_to :menu
  has_many :menu_items, dependent: :destroy

  # --validations--
  validates :name, presence: true
end
