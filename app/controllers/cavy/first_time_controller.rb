require_dependency 'cavy/application_controller'

module Cavy
  class FirstTimeController < ApplicationController

    layout 'cavy/first_time'
    before_action :check_if_first_time

    def new_user
    end

    def welcome
    end

    def create_user
      @user = Cavy::User.new(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation], role: "admin")
      @group = Cavy::Group.find_or_create_by(name: 'Admin', is_super_admin: true)

      if @user.save
        @user.cavy_groups << @group
        set_cookie_and_redirect(@user)
      else
        render action: 'new_user'
      end
    end

    private

    def set_cookie_and_redirect(user)
      cookies[:auth_token] = user.auth_token
      redirect_to(admin_dashboard_path, notice: "Logged in!")
    end

    def check_if_first_time
      redirect_to(root_path) if Cavy::User.count > 0
    end

  end
end