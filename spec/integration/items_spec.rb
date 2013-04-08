require 'spec_helper'

describe 'items'  do
  
  describe "show" do

    before(:each) do
      log_in('admin')
      @item = create(:cavy_item)
    end

    after(:each) do
      log_out
      @item.destroy
    end

    it "should be able to show an item" do
      visit cavy_item_path(locale: :en, id: @item.id)
      page.should have_content(@item.data['name'])
    end
  end

  describe "new" do
    before(:each) do
      log_in('admin')
      @group = create(:cavy_admin_item_group)
    end

    after(:each) do
      log_out
      @group.destroy
    end

    it "should be able to create a new item" do
      visit admin_item_group_path(locale: :en, id: @group.id)
      click_link('new-item')
      fill_in 'item[data][name]', with: 'ruby rainbows'
      click_button 'submit-item'
      @item = Cavy::Item.last
      @item.data['name'].should eq('ruby rainbows')
      @item.destroy
    end
  end

  describe "edit" do
    before(:each) do
      log_in('admin')
      @group = create(:cavy_admin_item_group)
    end

    after(:each) do
      log_out
      @group.destroy
    end

    it "should be able to edit an item" do
      visit admin_item_group_path(locale: :en, id: @group.id)
      click_link('new-item')
      fill_in 'item[data][name]', with: 'ruby rainbows'
      click_button 'submit-item'
      @item = Cavy::Item.last
      visit cavy_edit_item_path(locale: :en, id: @item.id)
      fill_in 'item[data][name]', with: 'diamond rainbows'
      click_button 'submit-item'
      @item = Cavy::Item.last
      @item.data['name'].should eq('diamond rainbows')
      @item.destroy
    end
  end

  describe "destroy" do
    before(:each) do
      log_in('admin')
      @group = create(:cavy_admin_item_group)
    end

    after(:each) do
      log_out
      @group.destroy
    end

    it "should be able to edit an item" do
      visit admin_item_group_path(locale: :en, id: @group.id)
      click_link('new-item')
      fill_in 'item[data][name]', with: 'ruby rainbows'
      click_button 'submit-item'
      visit admin_item_group_path(locale: :en, id: @group.id)
      count = Cavy::Item.count
      item = Cavy::Item.last
      click_link "delete-#{item.id}"
      Cavy::Item.count.should eq(count-1)
    end
  end
end