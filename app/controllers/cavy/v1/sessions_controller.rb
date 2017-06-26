require_dependency 'cavy/application_controller'

module Cavy::V1
  class SessionsController < ApplicationController

    def create
      user = ::Cavy::User.find_by(email: params[:email])
      json = if user && user.authenticate(params[:password])
               {
                 status: :ok,
                 token: encode_jwt_token(user)
               }
             else
               {
                 status: :error,
                 message: 'Email or Password invalid'
               }
             end

      respond_to do |format|
        format.json do
          render json: json
        end
      end
    end

  end
end