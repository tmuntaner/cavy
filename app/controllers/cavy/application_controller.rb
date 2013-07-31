module Cavy
  class ApplicationController < ActionController::Base

    before_action :authorize
    before_action :set_locale
    before_action :check_locale

    before_action :check_first_time

    helper_method :can_edit?
    helper_method :current_user
    helper_method :signed_in?
    helper_method :google_analytics_setup?
    
    delegate :allow?, to: :current_permission
    helper_method :allow?

    delegate :allow_param?, to: :current_permission
    helper_method :allow_param?

    private

    def google_analytics_setup?
      if Cavy.google_analytics_username || Cavy.google_analytics_password || Cavy.google_analytics_property_id
        return true
      end
      return false
    end

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale if I18n.available_locales.count > 1
    end

    def check_locale
      # there is a strange issue with redirect of root /en to /en/en, last check is an ugly fix
      if params[:locale].blank? and I18n.available_locales.count > 1 and request.path_info != "/#{I18n.default_locale}" 
        redirect_to "/#{I18n.default_locale}#{request.path_info}"
      end
    end

    def default_url_options(options = {})
      {locale: I18n.locale} if I18n.available_locales.count > 1
    end

    def can_edit?
      return true if signed_in? and current_user.site_manager?
      false
    end

    def current_user
      @current_user ||= User.find_by(auth_token: cookies[:auth_token]) if cookies[:auth_token]
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

    def check_first_time
      redirect_to cavy_first_time_welcome_path if Cavy::User.count == 0 and !(params[:controller] == 'cavy/first_time')
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
