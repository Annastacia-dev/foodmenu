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
require "test_helper"

class MenuCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
