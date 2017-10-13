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

require 'spec_helper'

describe Cavy::PageTemplate, type: :model do
  describe 'field options' do
    it 'provides a options array for select boxes' do
      options = [%w[string STRING], %w[text TEXT], %w[picture PICTURE]]
      expect(Cavy::PageTemplate.get_field_options_for_select).to eq(options)
    end
  end
end
