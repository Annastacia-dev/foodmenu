# == Schema Information
#
# Table name: menu_items
#
#  id                 :uuid             not null, primary key
#  alcoholic          :boolean          default(FALSE)
#  description        :string
#  gluten_free        :boolean          default(FALSE)
#  halal              :boolean          default(FALSE)
#  has_nuts           :boolean          default(FALSE)
#  ingredients        :jsonb
#  item_type          :integer          default(NULL)
#  lactose_intolerant :boolean          default(FALSE)
#  name               :string
#  price              :float
#  vegan              :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  menu_category_id   :uuid             not null
#
# Indexes
#
#  index_menu_items_on_menu_category_id  (menu_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (menu_category_id => menu_categories.id)
#
class MenuItem < ApplicationRecord
  has_paper_trail

  # --concerns--

  # --associations--
  belongs_to :menu_category

  # ---enums---
  enum item_type: { food: 1, drink: 2 }

  # --validations--
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
