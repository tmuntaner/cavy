module Cavy
  class ItemGroup < ::ActiveRecord::Base

    attr_accessor :param_string

    has_many :cavy_items

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
        self.params = param_string.gsub(/[,][ ]*/, ',').split(',')
      end
    end

  end
end
