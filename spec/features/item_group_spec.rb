require 'spec_helper'

describe 'item group' do

  describe 'index' do
    before(:each) do
      log_in('admin')
    end

    after(:each) do
      log_out
    end

    it 'should be able to go to index' do
      visit item_groups_path
      expect(current_path).to eq(item_groups_path(locale: :en))
    end

    it 'should not be able to visit index as a non user' do
      log_out
      visit item_groups_path
      expect(current_path).not_to eq(item_groups_path(locale: :en))
    end

    it 'should display a list of groups' do
      @group = create(:cavy_item_group)
      visit item_groups_path
      expect(page).to have_content(@group.title)
      @group.destroy
    end
  end

  describe 'show' do
    before(:each) do
      log_in('admin')
    end

    after(:each) do
      log_out
    end

    it 'should should be able to go to the show path for a item' do
      @group = create(:cavy_item_group)
      visit cavy_item_group_path(locale: :en, id: @group.id)
      expect(page).to have_content(@group.title)
      @group.destroy
    end
  end

  describe 'new' do
    before(:each) do
      log_in('admin')
    end

    after(:each) do
      log_out
    end

    it 'should be able to go to the new path' do
      visit admin_new_item_group_path(locale: :en)
      expect(current_path).to eq(admin_new_item_group_path(locale: :en))
    end

    it 'should be able to create a new item group' do
      visit admin_new_item_group_path(locale: :en)
      fill_in 'item_group_title', with: 'testfoo'
      fill_in 'item_group_param_string', with: 'test,bar'
      click_button 'Create'
      expect(page).to have_content('testfoo')
      @group = Cavy::ItemGroup.find_by(title: 'testfoo')
      expect(@group.params).to eq(%w(test bar))
      @group.destroy
    end
    it 'should not be able to create a new item group without a title' do
      visit admin_new_item_group_path(locale: :en)
      fill_in 'item_group_param_string', with: 'test, bar'
      click_button 'Create'
      expect(page).to have_content('error')
    end
  end

  describe 'edit' do
    before(:each) do
      log_in('admin')
      @group = create(:cavy_item_group)
    end

    after(:each) do
      log_out
      @group.destroy
    end

    it 'should be able to go to the edit path' do
      visit admin_edit_item_group_path(locale: :en, id: @group.id)
      expect(current_path).to eq(admin_edit_item_group_path(locale: :en, id: @group.id))
    end

    it 'should be able to edit an item group' do
      visit admin_edit_item_group_path(locale: :en, id: @group.id)
      fill_in 'item_group_title', with: 'testfoo'
      fill_in 'item_group_param_string', with: 'test,bar'
      click_button 'Create'
      @group = Cavy::ItemGroup.find(@group.id)
      expect(@group.params).to eq(%w(test bar))
      @group.destroy
    end
    it 'should not be able to update a new item group without a title' do
      visit admin_edit_item_group_path(locale: :en, id: @group.id)
      fill_in 'item_group_title', with: ''
      fill_in 'item_group_param_string', with: 'test, bar'
      click_button 'Create'
      expect(page).to have_content('error')
    end
  end

  describe 'destroy' do
    before(:each) do
      log_in('admin')
      @group = create(:cavy_item_group)
    end

    after(:each) do
      log_out
    end

    it 'should destroy a group item' do
      count = Cavy::ItemGroup.count
      visit item_groups_path(locale: :en)
      click_link("delete-#{@group.id}")
      expect(Cavy::ItemGroup.count).to eq(count-1)
    end
  end
end