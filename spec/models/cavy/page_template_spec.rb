require 'spec_helper'

module Cavy
  RSpec.describe PageTemplate, type: :model do

    describe 'field options' do

      it 'should be able to provide a options array for select boxes' do
        options = [%w(string STRING), %w(text TEXT), %w(picture PICTURE)]
        expect(Cavy::PageTemplate.get_field_options_for_select).to eq(options)
      end

    end
  end
end
