class RestaurantMailerPreview < ActionMailer::Preview
  def confirmation_email
    restaurant = Restaurant.first
    RestaurantMailer.with(restaurant: restaurant).confirmation_email
  end
end