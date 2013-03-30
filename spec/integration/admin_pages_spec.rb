require 'spec_helper'

module Cavy
  describe 'Admin Pages Interface' do

    describe 'admin/developer/designer user role' do

      before(:each) do
        log_in('admin')
      end

      after(:each) do
        log_out
      end
      
      it "should be able to go to the new page page" do
        visit '/admin'
        click_link 'admin-new-page'
        page.should have_content('New Page')
      end

      it "should be able to add a new page" do
        visit '/admin'
        click_link 'admin-new-page'
        fill_in 'page_title',   with: 'foobar'
        fill_in 'page_render',  with: 'cavy_test/pages/test'
        click_on 'submit_page'
        @page = Cavy::Page.find_by(title: 'foobar')
        @page.render.should eq('cavy_test/pages/test')
      end

      it "should be able to edit a page" do
        @page = FactoryGirl.create(:cavy_page)
        visit '/admin'
        click_link 'admin-pages'
        click_link "edit-page-#{@page.id}"
        fill_in 'page_title',   with: 'foobar'
        fill_in 'page_render',  with: 'cavy_test/pages/test'
        fill_in 'page_tag_string',    with: 'foo,bar'
        fill_in 'page_route',   with: 'foos'
        fill_in 'page_description', with: 'foo'
        click_on 'submit_page'
        @page = Cavy::Page.find(@page.id)
        @page.render.should eq('cavy_test/pages/test')
        @page.tags.should eq(['foo','bar'])
        @page.route.should eq('foos')
        @page.description.should eq('foo')
      end

      it "shouldn't be able to edit a page without a title" do
        @page = FactoryGirl.create(:cavy_page, title: 'home-foo')
        visit '/admin'
        click_link 'admin-pages'
        click_link "edit-page-#{@page.id}"
        fill_in 'page_title',   with: ''
        fill_in 'page_render',  with: 'cavy_test/pages/test'
        click_on 'submit_page'
        @page = Page.find_by(content: @page.content)
        @page.title.should eq('home-foo')
      end

      it "should be able to delete a page" do
        @page = FactoryGirl.create(:cavy_page)
        visit '/admin'
        click_link 'admin-pages'
        click_link "delete-page-#{@page.id}"
        @pages = Cavy::Page.all
        @pages.size.should eq(0)
      end

      it "should not be able to add a new page with invalid info" do
        visit '/admin'
        click_link 'admin-new-page'
        fill_in 'page_render',  with: 'cavy_test/pages/test'
        click_on 'submit_page'
        page.should have_content('error')
      end

      it "should be able to go to the list of pages" do
        @page = FactoryGirl.create(:cavy_page)
        visit '/admin'
        click_link 'admin-pages'
        page.should have_content('Website Pages')
        page.should have_content(@page.title)
        @page.destroy
      end

      it "should allow you go to the page page" do
        @page = FactoryGirl.create(:cavy_page)
        visit '/admin'
        click_link 'admin-pages'
        click_link "page-#{@page.id}"
        page.should have_content(@page.description)
        @page.destroy
      end

      it "should allow you go to go to the edit settings page through the show page" do
        @page = FactoryGirl.create(:cavy_page)
        visit '/admin'
        click_link 'admin-pages'
        click_link "page-#{@page.id}"
        click_link 'edit-page-settings'
        page.should have_content('Edit')
        @page.destroy
      end

      it "should allow you go to go to the edit content page through the show page" do
        @page = FactoryGirl.create(:cavy_page)
        visit '/admin'
        click_link 'admin-pages'
        click_link "page-#{@page.id}"
        click_link 'edit-page-content'
        page.should have_content(@page.content)
        @page.destroy
      end
    end

    describe 'client user role' do

      before(:each) do
        log_in('client')
      end

      after(:each) do
        log_out
      end

      it "should not allow a client to edit the route" do
        log_in_rack('client')
        @page = FactoryGirl.create(:cavy_page)
        @parameters = { page: { title: 'ghost', tag_string: 'foo,bar,s', description: 'fooghostbarsummer',route: 'ghostenbear'}}
        put admin_update_page_path({locale: :en, id: @page.id}), @parameters
        @page = Cavy::Page.find(@page.id)
        @page.title.should eq('ghost')
        @page.tags.should eq(['foo','bar','s'])
        @page.description.should eq('fooghostbarsummer')
        @page.route.should_not eq('ghostenbear')
        @page.destroy
      end

      it "should not allow a client to go to the new page route" do
        visit admin_new_page_path
        page.should have_content('I am sorry')
      end
    end

  end
end