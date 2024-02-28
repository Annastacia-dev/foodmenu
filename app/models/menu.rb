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
class Menu < ApplicationRecord
  has_paper_trail

  # --concerns--

  # --associations--
  belongs_to :restaurant
  belongs_to :sub_restaurant, optional: true
  has_many :menu_categories, dependent: :destroy
  has_many :menu_items, through: :menu_categories

  attr_writer :current_step

  # --enums--
  enum tax_behavior: { inclusive: 0, exclusive: 1 }

  # --methods--
  def current_step
    @current_step || steps.first
  end

  def steps
    %w[menu_info menu_categories menu_items]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def previous_step
    return if first_step?

    steps[steps.index(current_step) - 1]
  end

  def next_step
    return if last_step?

    steps[steps.index(current_step) + 1]
  end

  def menu_name
    name ||  sub_restaurant&.name || restaurant&.name
  end

end
