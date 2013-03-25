module Cavy
  class ApplicationController < ActionController::Base

    helper_method :can_edit?

    private

    def can_edit?
      true
    end
  end
end
