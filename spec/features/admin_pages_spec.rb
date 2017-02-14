require 'spec_helper'

module Cavy
  describe AdminPagesController, type: :request do

    describe 'admin/developer/designer user role' do

      before(:each) do
        I18n.locale = :en
        log_in('admin')
      end

      after(:each) do
        log_out
      end

      it 'should be able to go to the new page page' do
        visit '/admin'
        click_link 'admin-pages'
        click_link 'admin-new-page'
        expect(page).to have_content('New Page')
      end

      it 'should be able to add a new page' do
        visit '/admin'
        click_link 'admin-pages'
        click_link 'admin-new-page'
        fill_in 'page_title', with: 'foobar'
        fill_in 'page_render', with: 'cavy_test/pages/test'
        click_on 'submit_page'
        @page = Cavy::Page.last
        expect(@page.render).to eq('cavy_test/pages/test')
      end

      it 'should be able to edit page settings' do
        @page = FactoryGirl.create(:cavy_page)
        visit '/admin'
        click_link 'admin-pages'
        click_link "edit-page-#{@page.id}"
        fill_in 'page_title', with: 'foobar'
        fill_in 'page_tag_string', with: 'foo,bar'
        fill_in 'page_route', with: 'foos'
        fill_in 'page_description', with: 'foo'
        click_on 'submit_page_settings'
        @page = Cavy::Page.find(@page.id)
        expect(@page.tags).to eq(%w(foo bar))
        expect(@page.route).to eq('foos')
        expect(@page.description).to eq('foo')
      end

      it 'should be able to edit page content' do
        @page = FactoryGirl.create(:cavy_page)
        visit '/admin'
        click_link 'admin-pages'
        click_link "edit-page-#{@page.id}"
        fill_in 'page_title', with: 'title'
        fill_in 'item[page_elements][content]', with: 'foo'
        fill_in 'item[page_elements][element]', with: 'bar'
        click_on 'submit_page_content'
        @page = Cavy::Page.find(@page.id)
        expect(@page.get_page_element('content')).to eq('foo')
        expect(@page.localized_title).to eq('title')
        expect(@page.get_page_element('element')).to eq('bar')
      end

      it 'should be able to go to the list of pages' do
        @page = FactoryGirl.create(:cavy_page)
        visit '/admin'
        click_link 'admin-pages'
        expect(page).to have_content('Website Pages')
        expect(page).to have_content(@page.localized_title)
        @page.destroy
      end

      it 'should be able to add data' do
        @page = FactoryGirl.create(:cavy_page)
        visit '/admin'
        click_link 'admin-pages'
        click_link "edit-page-#{@page.id}"
        click_link "edit-page-data-#{@page.id}"
        fill_in 'page[key]', with: 'test'
        fill_in 'page[value]', with: 'value'
        click_button 'submit'
        @page = Cavy::Page.last
        expect(@page.data['test']).to eq('value')
        @page.destroy
      end
    end

    describe 'client user role' do

      before(:each) do
        log_in_rack('client')
      end

      after(:each) do
        log_out
      end

      it 'should not allow a client to edit the route' do
        log_in('client')
        @page = FactoryGirl.create(:cavy_page)
        @parameters = {page: {title: 'ghost', tag_string: 'foo,bar,s', description: 'fooghostbarsummer', route: 'ghostenbear'}}
        put admin_update_page_path({locale: :en, id: @page.id}), params: @parameters
        @page = Cavy::Page.last
        expect(@page.tags).to eq(%w(foo bar s))
        expect(@page.description).to eq('fooghostbarsummer')
        expect(@page.route).not_to eq('ghostenbear')
        @page.destroy
      end

      it 'should not allow a client to go to the new page route' do
        visit admin_new_page_path
        expect(page).to have_content('Please Sign In to Continue')
      end
    end

  end
end
