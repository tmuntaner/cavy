module Cavy
  class Item < ApplicationRecord

    belongs_to :cavy_item_group

    def create_params(type,params)
      data = {}
      data['type'] = type
      params.try(:each) do |param|
        data["#{param.downcase.gsub(' ', '_')}"] = ''
      end
      self.data = data
    end

  end
end
