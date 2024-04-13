class Users::RegistrationsController < Devise::RegistrationsController

  def create
    @restaurant = Restaurant.friendly.find(params[:user][:restaurant_id])
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?

    if resource.persisted?
      sign_up(resource_name, resource)
      if resource.restaurant_user?
        if resource.admin?
          if resource.restaurant.single?
            flash[:notice] = 'Please set up your menu.'
            redirect_to new_restaurant_menu_path(resource.restaurant)
          elsif resource.restaurant.chain?
            flash[:notice] = 'Please set up your locations.'
            redirect_to new_location_path
          elsif resource.restaurant.group?
            flash[:notice] = 'Please set up your sub restaurants.'
            redirect_to new_restaurant_sub_restaurant_path(resource.restaurant)
          end
        end
      else
        redirect_to root_path
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

end