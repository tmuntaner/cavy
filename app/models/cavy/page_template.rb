# == Schema Information
#
# Table name: cavy_page_templates
#
#  id         :integer          not null, primary key
#  name       :string
#  template   :string
#  fields     :hstore
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module Cavy
  class PageTemplate < ApplicationRecord
    @options = [
      { name: 'string', type: 'STRING' },
      { name: 'text', type: 'TEXT' },
      { name: 'picture', type: 'PICTURE' }
    ]

    def self.get_field_options_for_select
      @options.map { |o| [o[:name], o[:type]] }
    end

    def add_field(field, type)
      self.fields ||= {}
      fields[field] = type
      save
    end

    def remove_field(field)
      self.fields ||= {}
      fields.delete field
      save
    end
  end
end
