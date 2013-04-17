module Cavy
  class ItemGroup < ActiveRecord::Base

    has_many :items

    attr_accessor :param_string

    before_save :set_params

    validates :title, presence: true
    
    def type
      return title.downcase.gsub(' ', '_')
    end

    def items
      Cavy::Item.where(group_id: id)
    end

    def items_with_key_value(key,value)
      Cavy::Item.where('group_id = ? AND data @> hstore(?,?)', id, key, value)
    end

    private

    def set_params
      unless param_string == '' or param_string == nil
        self.params = param_string.split(',')
      end
    end
    
  end
end
