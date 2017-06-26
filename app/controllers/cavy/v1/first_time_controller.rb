module Cavy::V1
  class FirstTimeController < ApplicationController

    def index
      respond_to do |format|
        format.json do
          render json: {
              status: :ok,
              first_time: (::Cavy::User.all.count == 0) ? :true : :false
          }
        end
      end
    end

  end
end
