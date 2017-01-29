require 'spec_helper'

module Cavy
  describe Item do

    describe 'data' do
      it 'should be able to accept no data' do
        @item = create(:cavy_item, data: {})
        expect(@item).to be_valid
        @item.destroy
      end
      it 'should be able to accept a hash of data' do
        @item = create(:cavy_item, data: {foo: 'bar', bar: 'foo'})
        expect(@item.data).to eq({'foo' => 'bar', 'bar' => 'foo'})
        expect(@item).to be_valid
        @item.destroy
      end
      it 'should be able to create params from array' do
        @item = create(:cavy_item, data: {})
        @item.create_params('test', %w(Ruby Rainbows))
        expect(@item.data).to eq({'type' => 'test', 'ruby' => '', 'rainbows' => ''})
      end
    end

  end
end
