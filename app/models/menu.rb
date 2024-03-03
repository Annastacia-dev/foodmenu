# == Schema Information
#
# Table name: menus
#
#  id                :uuid             not null, primary key
#  description       :string
#  name              :string
#  show_calories     :boolean          default(FALSE)
#  slug              :string
#  tax_behavior      :integer          default("inclusive")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  restaurant_id     :uuid             not null
#  sub_restaurant_id :uuid
#
# Indexes
#
#  index_menus_on_restaurant_id      (restaurant_id)
#  index_menus_on_slug               (slug) UNIQUE
#  index_menus_on_sub_restaurant_id  (sub_restaurant_id)
#
# Foreign Keys
#
#  fk_rails_...  (restaurant_id => restaurants.id)
#  fk_rails_...  (sub_restaurant_id => sub_restaurants.id)
#
class Menu < ApplicationRecord
  has_paper_trail

  # --concerns--
  include SluggableModelConcern
  friendly_slug_scope to_slug: :menu_name

  # --associations--
  belongs_to :restaurant
  belongs_to :sub_restaurant, optional: true
  has_many :menu_categories, dependent: :destroy
  has_many :menu_items, through: :menu_categories

  # --enums--
  enum tax_behavior: { inclusive: 0, exclusive: 1 }

  # --validations--
  validates :name, uniqueness: { scope: %i[restaurant_id sub_restaurant_id] }, if: -> { name.present? }

  def menu_name
    name ||  sub_restaurant&.name || restaurant&.name
  end

end
