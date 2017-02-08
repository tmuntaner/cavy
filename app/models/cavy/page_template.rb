module Cavy
  class PageTemplate < ApplicationRecord
    @options = [
        {name: 'string', type: 'STRING'},
        {name: 'text', type: 'TEXT'}
    ]

    def self.get_field_options_for_select
      @options.map { |o| [o[:name], o[:type]] }
    end

    def add_field(field, type)
      fields[field] = type
      save
    end

    def remove_field(field)
      fields.delete field
      save
    end
  end
end
