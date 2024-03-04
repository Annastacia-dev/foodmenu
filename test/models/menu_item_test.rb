# == Schema Information
#
# Table name: menu_items
#
#  id               :uuid             not null, primary key
#  alcoholic        :boolean          default(FALSE)
#  calories_info    :text
#  description      :string
#  gluten_free      :boolean          default(FALSE)
#  halal            :boolean          default(FALSE)
#  has_nuts         :boolean          default(FALSE)
#  ingredients      :jsonb
#  item_type        :integer          default(NULL)
#  lactose_free     :boolean          default(FALSE)
#  name             :string
#  price            :float
#  slug             :string
#  vegan            :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  menu_category_id :uuid             not null
#
# Indexes
#
#  index_menu_items_on_menu_category_id  (menu_category_id)
#  index_menu_items_on_slug              (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (menu_category_id => menu_categories.id)
#
require "test_helper"

class MenuItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
