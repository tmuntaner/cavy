module Cavy
  class Item < ActiveRecord::Base

    def create_params(type,params)
      data = {}
      data['type'] = type
      params.try(:each) do |param|
        data["#{param.downcase.gsub(' ', '_')}"] = ''
      end
      update(data: data)
    end
  end
end
