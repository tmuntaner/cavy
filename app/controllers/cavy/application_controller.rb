module Cavy
  class ApplicationController < ActionController::Base

    before_action :check_first_time

    before_action :authorize
    before_action :set_locale
    before_action :redirect_to_localized_url

    helper_method :can_edit?
    helper_method :current_user
    helper_method :signed_in?

    delegate :allow?, to: :current_permission
    helper_method 'allow?'

    delegate :allow_param?, to: :current_permission
    helper_method 'allow_param?'

    private

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def redirect_to_localized_url
      redirect_to "/#{I18n.default_locale}#{request.path_info}" if params[:locale].blank? and I18n.available_locales.count > 1
    end

    def default_url_options(options = {})
      {locale: I18n.locale} if I18n.available_locales.count > 1
    end

    def can_edit?
      signed_in? and current_user.site_manager?
    end

    def current_user
      @current_user ||= User.includes(cavy_groups: [:cavy_policies]).find_by(auth_token: cookies[:auth_token]) if cookies[:auth_token]
    end

    def signed_in?
      !current_user.nil?
    end

    def check_first_time
      return if signed_in? || !(Cavy.is_first_time? and !is_in_first_time_controller?)
      redirect_to cavy_first_time_welcome_path
    end

    def is_in_first_time_controller?
      params[:controller] == 'cavy/first_time'
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
          redirect_to root_url, alert: 'I am sorry, you are not authorized for this page.'
        elsif !Cavy.is_first_time?
          session[:return_to] = request.fullpath
          redirect_to admin_signin_path, alert: 'Please log in first to view the previous page.'
        end
      end
    end

  end
end
