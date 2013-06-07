module Cavy
  class Item

    include Mongoid::Document

    field :data, type: Hash
    field :position, type: Integer

    belongs_to :item_group, inverse_of: :items
    
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
