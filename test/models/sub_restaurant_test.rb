# == Schema Information
#
# Table name: sub_restaurants
#
#  id            :uuid             not null, primary key
#  description   :text
#  email         :string
#  name          :string           not null
#  phone_number  :string
#  slug          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  layout_id     :uuid
#  restaurant_id :uuid             not null
#
# Indexes
#
#  index_sub_restaurants_on_layout_id      (layout_id)
#  index_sub_restaurants_on_restaurant_id  (restaurant_id)
#
# Foreign Keys
#
#  fk_rails_...  (layout_id => layouts.id)
#  fk_rails_...  (restaurant_id => restaurants.id)
#
require "test_helper"

class SubRestaurantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
