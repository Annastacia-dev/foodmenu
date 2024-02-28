# == Schema Information
#
# Table name: menus
#
#  id                :uuid             not null, primary key
#  description       :string
#  name              :string
#  tax_behavior      :integer          default(0)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  restaurant_id     :uuid             not null
#  sub_restaurant_id :uuid
#
# Indexes
#
#  index_menus_on_restaurant_id      (restaurant_id)
#  index_menus_on_sub_restaurant_id  (sub_restaurant_id)
#
# Foreign Keys
#
#  fk_rails_...  (restaurant_id => restaurants.id)
#  fk_rails_...  (sub_restaurant_id => sub_restaurants.id)
#
require "test_helper"

class MenuTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
