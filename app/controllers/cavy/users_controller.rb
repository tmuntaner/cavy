require_dependency "cavy/application_controller"

module Cavy
  class UsersController < ApplicationController

    before_action :set_user, only: [:show, :edit, :update, :destroy]
    layout 'cavy/sessions'

    def index
      @users = User.all
    end

    def show
    end

    def new
      @user = User.new
    end

    def edit
    end

    def create
      @user = User.new(user_params)

      if @user.save
        redirect_to @user, notice: 'User was successfully created.'
      else
        render action: 'new'
      end
    end

    def update
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render action: 'edit'
      end
    end

    def destroy
      @user.destroy
      redirect_to users_url, notice: 'User was successfully destroyed.'
    end

    private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        @role = params[:user][:role]
        params.require(:user).permit(:email, :password, :name)
      end
  end
end
