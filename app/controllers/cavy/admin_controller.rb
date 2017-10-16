require_dependency 'cavy/application_controller'

module Cavy
  class AdminController < ApplicationController
    layout 'cavy/admin_layout'

    def dashboard
      @users = Cavy::User.all
      @pages = Cavy::Page.all
    end

    def system; end
  end
end
