class RestaurantMailer < ApplicationMailer
  def confirmation_email
    @restaurant = params[:restaurant]
    subject = 'Welcome to foodmenu - Confirm your email'
    mail(
      to: @restaurant.email,
      subject: subject
    )
  end
end