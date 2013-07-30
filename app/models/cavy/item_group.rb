module Cavy
  class ItemGroup

    include Mongoid::Document

    field :title
    field :params, type: Array

    belongs_to :item_section, inverse_of: :item_groups

    has_many :items

    attr_accessor :param_string

    before_save :set_params

    validates :title, presence: true
    
    def type
      return title.downcase.gsub(' ', '_')
    end

    def items
      Cavy::Item.where(item_group_id: id)
    end

    def items_with_key_value(key,value)
      item_group = Cavy::ItemGroup.find(id)
      item_group.items.where("data.#{key}" => value)
    end

    private

    def set_params
      unless param_string == '' or param_string == nil
        self.params = param_string.split(',')
      end
    end
    
  end
end
