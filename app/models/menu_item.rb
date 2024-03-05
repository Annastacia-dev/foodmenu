# == Schema Information
#
# Table name: menu_items
#
#  id               :uuid             not null, primary key
#  alcoholic        :boolean          default(FALSE)
#  calories_info    :text
#  contains_nuts    :boolean          default(FALSE)
#  description      :string
#  gluten_free      :boolean          default(FALSE)
#  halal            :boolean          default(FALSE)
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
class MenuItem < ApplicationRecord
  has_paper_trail

  attr_writer :current_step

  # --callbacks--
  before_save :downcase_name

  # --concerns--
  include SluggableModelConcern
  friendly_slug_scope to_slug: :name

  # --associations--
  belongs_to :menu_category
  has_many_attached :images
  has_many_attached :videos

  # --validations--
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true

  # --scopes--

  # --class methods--

  # --instance methods--

  # --private--
  private

  def downcase_name
    self.name = name.downcase
  end
end
