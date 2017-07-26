module Cavy
  class ItemGroup < ::ActiveRecord::Base

    attr_accessor :param_string

    has_many :cavy_items

    before_save :set_params
    validates :title, presence: true

    def type
      title.downcase.gsub(' ', '_')
    end

    def items
      Cavy::Item.where(item_group_id: id)
    end

    def items_json
      all_items = {}
      items.each do |item|
        item_json = {}
        item.data.try(:each) { |key, value| item_json[key] = value }
        all_items[item.id] = item_json
      end
      all_items.to_json
    end

    def items_with_key_value(key, value)
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
