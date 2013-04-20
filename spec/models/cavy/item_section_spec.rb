require 'spec_helper'

module Cavy
  describe ItemSection do
    describe 'title' do
      it 'should be able to set a title' do
        @section = create(:cavy_item_section, title: 'ghost is awesome')
        @section.should be_valid
      end

      it 'should not be able to set the same title twice' do
        @section1 = create(:cavy_item_section, title: 'summer')
        @section2 = build(:cavy_item_section, title: 'summer')
        @section2.should_not be_valid
      end
    end
  end
end
