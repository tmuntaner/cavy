require_dependency "cavy/application_controller"

module Cavy
  class SessionsController < ApplicationController

    layout 'cavy/admin_layout'

    def new
    end

    def create
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        set_cookie_and_redirect(user)
      else
        flash.now.alert = "Email or password is invalid"
        render "new"
      end
    end

    def destroy
      cookies.delete(:auth_token)
      redirect_to root_path, notice: "Logged out!"
    end

    private

    def set_cookie_and_redirect(user)
      cookies[:auth_token] = user.auth_token
      redirect_to(session[:return_to] || root_path, notice: "Logged in!")
      session.delete(:return_to)
    end
  end
end
