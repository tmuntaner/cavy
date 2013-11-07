require 'spec_helper'

module Cavy
  describe ItemGroup do

    describe 'title' do
      it "should accept a group with a title" do
        @group = ItemGroup.create(title: 'foo')
        @group.should be_valid
        @group.destroy
      end
      it "should not accept a groupd without a title" do
        @group = ItemGroup.create()
        @group.should_not be_valid
        @group.destroy
      end
      it "should create a valid type from title" do
        @group = create(:cavy_item_group, title: 'foo Bar')
        @group.type.should eq('foo_bar')
        @group.destroy
      end

    end

    describe 'params' do
      it "should accept no params" do
        @group = create(:cavy_item_group, params: '')
        @group.should be_valid
        @group.destroy
      end
      it "should accept no param string" do
        @group = create(:cavy_item_group, param_string: '')
        @group.should be_valid
        @group.destroy
      end
      it "should accept an array of params" do
        @group = create(:cavy_item_group, params: ['Ruby','Rainbows'], param_string: '')
        @group.params.should eq(['Ruby','Rainbows'])
        @group.should be_valid
        @group.destroy
      end
      it "should accept a string of params" do
        @group = create(:cavy_item_group, param_string: 'Ruby,Rainbows')
        @group.params.should eq(['Ruby','Rainbows'])
        @group.should be_valid
        @group.destroy
      end
      it "should accept a string of params and a space" do
        @group = create(:cavy_item_group, param_string: 'Ruby, Rainbows')
        @group.params.should eq(['Ruby','Rainbows'])
        @group.should be_valid
        @group.destroy
      end
      it "should accept a string of params and handle spaces" do
        @group = create(:cavy_item_group, param_string: 'Ruby,      Rainbows')
        @group.params.should eq(['Ruby','Rainbows'])
        @group.should be_valid
        @group.destroy
      end
    end

    describe "items" do
      before(:each) do
        @guineapigs = create(:cavy_item_group, param_string: 'name,group')
        @pig1 = @guineapigs.items.create(data: {name: 'ghost',          group: 'team_ghost'})
        @pig2 = @guineapigs.items.create(data: {name: 'summer',         group: 'team_summer'})
        @pig3 = @guineapigs.items.create(data: {name: 'pumpkin spice',  group: 'team_ghost'})
        @pig4 = @guineapigs.items.create(data: {name: 'greywind',       group: 'team_summer'})
      end
      after(:each) do
        @guineapigs.destroy
        @pig1.destroy
        @pig2.destroy
        @pig3.destroy
        @pig4.destroy
      end

      it "should list all guinea pigs" do
        @guineapigs.items.map(&:id).should eq([@pig1.id,@pig2.id,@pig3.id,@pig4.id])
      end

      it "should only list team ghost" do
        @guineapigs.items_with_key_value('group','team_ghost').map(&:id).should eq([@pig1.id,@pig3.id])
      end
    end
  end
end
