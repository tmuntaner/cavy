require 'spec_helper'

module Cavy
  describe Item do
    
    describe 'name' do
      it "should be able to accept a name" do
        @item = Item.create(name: 'foo')
        @item.should be_valid
        @item.destroy
      end
    end

    describe 'data' do
      it "should be able to accept no data" do
        @item = create(:cavy_item, data: '')
        @item.should be_valid
        @item.destroy
      end
      it "should be able to accept a hash of data" do
        @item = create(:cavy_item, data: {foo:'bar',bar:'foo'})
        @item.data.should eq({foo:'bar',bar:'foo'})
        @item.should be_valid
        @item.destroy
      end
      it "should be able to create params from array" do
        @item = create(:cavy_item, data: '')
        @item.create_params('test',['Ruby', 'Rainbows'])
        @item.data.should eq({"type" => 'test', "ruby" => '', "rainbows" => ''})
      end
    end

  end
end
