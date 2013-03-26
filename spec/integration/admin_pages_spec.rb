require 'spec_helper'

module Cavy
  describe 'Admin Pages Interface' do

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
      @page.destroy
    end

    it "should be able to edit a page" do
      @page = Page.create(title: 'home-foo', content: 'foobar')
      visit '/admin'
      click_link 'admin-pages'
      click_link "edit-page-#{@page.id}"
      fill_in 'page_title',   with: 'foobar'
      fill_in 'page_render',  with: 'cavy_test/pages/test'
      click_on 'submit_page'
      @page = Cavy::Page.find_by(title: 'foobar')
      @page.render.should eq('cavy_test/pages/test')
      @page.destroy
    end

    it "shouldn't be able to edit a page without a title" do
      @page = Page.create(title: 'home-foo', content: 'foobar')
      visit '/admin'
      click_link 'admin-pages'
      click_link "edit-page-#{@page.id}"
      fill_in 'page_title',   with: ''
      fill_in 'page_render',  with: 'cavy_test/pages/test'
      click_on 'submit_page'
      @page = Page.find_by(content: 'foobar')
      @page.title.should eq('home-foo')
    end

    it "should be able to edit a page" do
      @page = Page.create(title: 'home-foo', content: 'foobar')
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
      @page = Page.create(title: 'home-foo', content: 'foobar')
      visit '/admin'
      click_link 'admin-pages'
      page.should have_content('Website Pages')
      page.should have_content('home-foo')
      @page.destroy
    end

    it "should allow you go to the page page" do
      @page = Page.create(title: 'home-foo', content: 'foobar')
      visit '/admin'
      click_link 'admin-pages'
      click_link "page-#{@page.id}"
      page.should have_content('home-foo')
      @page.destroy
    end

    it "should allow you go to go to the edit settings page through the show page" do
      @page = Page.create(title: 'home-foo', content: 'foobar')
      visit '/admin'
      click_link 'admin-pages'
      click_link "page-#{@page.id}"
      click_link 'edit-page-settings'
      page.should have_content('Edit')
      @page.destroy
    end

    it "should allow you go to go to the edit content page through the show page" do
      @page = Page.create(title: 'home-foo', content: 'foobar')
      visit '/admin'
      click_link 'admin-pages'
      click_link "page-#{@page.id}"
      click_link 'edit-page-content'
      page.should have_content(@page.content)
      @page.destroy
    end

  end
end