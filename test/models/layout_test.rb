# == Schema Information
#
# Table name: layouts
#
#  id          :uuid             not null, primary key
#  description :text             not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class LayoutTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
