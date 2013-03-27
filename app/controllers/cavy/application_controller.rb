module Cavy
  class ApplicationController < ActionController::Base

    before_action :authorize

    helper_method :can_edit?
    helper_method :current_user
    helper_method :signed_in?

    delegate :allow?, to: :current_permission
    helper_method :allow?

    private

    def can_edit?
      return true if signed_in?
      false
    end

    def current_user
      @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
    end

    def signed_in?
      current_user ? true : false
    end

    def current_permission
      @current_permission ||= Permissions.permission_for(current_user)
    end

    def current_resource
      nil
    end

    def authorize
      if current_permission.allow?(params[:controller], params[:action], current_resource)
       current_permission.permit_params! params
      else
        if signed_in?
          redirect_to root_url, alert: "I am sorry, you are not authorized for this page."
        else
          session[:return_to] = request.fullpath
          redirect_to admin_signin_path, alert: "Please log in first to view the previous page."
        end
      end
    end

  end
end
