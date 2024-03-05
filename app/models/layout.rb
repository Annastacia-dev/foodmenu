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
class Layout < ApplicationRecord
  has_paper_trail

  # --- associations ---
  has_many :restaurants, dependent: :nullify
  has_many :sub_restaurants, dependent: :nullify
  has_one_attached :image

  # --- validations ---
  validates :description, presence: true
  validates :name, presence: true
end
