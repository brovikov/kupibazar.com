# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
 
    rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
    def after_sign_in_path_for(resource)
      #orders_path
      static_pages_about_path
    end
#    include SessionsHelper

  # Force signout to prevent CSRF attacks
#  def handle_unverified_request
#    sign_out
#    super
#  end
end
