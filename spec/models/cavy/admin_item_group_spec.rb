require 'spec_helper'

module Cavy
  describe AdminItemGroup do

    describe 'title' do
      it "should accept a group with a title" do
        @group = AdminItemGroup.create(title: 'foo')
        @group.should be_valid
        @group.destroy
      end
      it "should not accept a groupd without a title" do
        @group = AdminItemGroup.create()
        @group.should_not be_valid
        @group.destroy
      end
      it "should create a valid type from title" do
        @group = create(:cavy_admin_item_group, title: 'foo Bar')
        @group.type.should eq('foo_bar')
        @group.destroy
      end

    end

    describe 'params' do
      it "should accept no params" do
        @group = create(:cavy_admin_item_group, params: '')
        @group.should be_valid
        @group.destroy
      end
      it "should accept no param string" do
        @group = create(:cavy_admin_item_group, param_string: '')
        @group.should be_valid
        @group.destroy
      end
      it "should accept an array of params" do
        @group = create(:cavy_admin_item_group, params: ['Ruby','Rainbows'], param_string: '')
        @group.params.should eq(['Ruby','Rainbows'])
        @group.should be_valid
        @group.destroy
      end
      it "should accept a string of params" do
        @group = create(:cavy_admin_item_group, param_string: 'Ruby,Rainbows')
        @group.params.should eq(['Ruby','Rainbows'])
        @group.should be_valid
        @group.destroy
      end
    end
  end
end
