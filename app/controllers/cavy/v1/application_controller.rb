module Cavy::V1
  class ApplicationController < ::Cavy::ApplicationController

    before_action :authorize

    private

    def default_url_options(options = {})
      # stub
    end

    def redirect_to_localized_url
      # stub
    end

    def set_locale
      # stub
    end

    def find_user
      ::Cavy::User.find_by(id: decoded_jwt_token['user']) if jwt_auth_present?
    end

    def encode_jwt_token(user)
      ::Cavy::JsonWebToken.encode(user: user.id)
    end

    def decoded_jwt_token
      ::Cavy::JsonWebToken.decode(jwt_token)
    end

    def jwt_token
      auth_header.scan(/Bearer\s(.*)$/).flatten.last
    end

    def jwt_auth_present?
      !auth_header.scan(/Bearer/).empty?
    end

    def auth_header
      request.env.fetch('HTTP_AUTHORIZATION', '')
    end

    def current_permission
      @current_permission ||= ::Cavy::Permissions.permission_for(current_user)
    end

    def authorize
      if current_permission.allow?(params[:controller], params[:action], nil)
        current_permission.permit_params! params
      else
        render json: { status: 'unauthorized' }, status: 401
        false
      end
    end
  end

end
