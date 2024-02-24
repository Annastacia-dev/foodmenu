# == Schema Information
#
# Table name: templates
#
#  id              :uuid             not null, primary key
#  name            :string
#  price           :float
#  primary_color   :string
#  secondary_color :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Template < ApplicationRecord
end
