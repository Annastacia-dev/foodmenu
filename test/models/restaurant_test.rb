# == Schema Information
#
# Table name: restaurants
#
#  id              :uuid             not null, primary key
#  confirmed       :boolean          default(FALSE)
#  confirmed_at    :datetime
#  currency        :string           default("KES")
#  email           :string           not null
#  name            :string           not null
#  phone           :string           not null
#  restaurant_type :integer          default("single_restaurant(one restaurant, one location)")
#  slug            :string           not null
#  status          :integer          default("active")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require "test_helper"

class RestaurantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
