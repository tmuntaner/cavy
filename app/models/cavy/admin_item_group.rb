module Cavy
  class AdminItemGroup < ActiveRecord::Base

    attr_accessor :param_string

    before_save :set_params

    validates :title, presence: true
    
    def type
      return title.downcase.gsub(' ', '_')
    end

    def items
      Cavy::Item.where('data @> hstore(?,?)', 'type', type)
    end

    private

    def set_params
      unless param_string == '' or param_string == nil
        self.params = param_string.split(',')
      end
    end
    
  end
end
