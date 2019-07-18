require_dependency 'cavy/application_controller'

module Cavy
  class AdminController < ApplicationController
    layout 'cavy/admin_layout'

    def dashboard
      redirect_to admin_pages_path
    end

    def system; end
  end
end
