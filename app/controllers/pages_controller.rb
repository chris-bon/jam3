class PagesController < ApplicationController
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :configure_permitted_parameters, if: :devise_controller?

  def about
  end

  def contact
  end

  def email
  end

  def homepage
  end

  def settings
  end

  def timeline
  end

  def configure_permitted_parameters
    added_attributes = [:username, :email, :password, :password_confirmation, 
                        :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attributes
    devise_parameter_sanitizer.permit :account_update, keys: added_attributes
  end
end
