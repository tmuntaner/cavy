require 'spec_helper'

module Cavy
  describe 'Admin Interface' do

    it "should be able to go to the home page" do
      visit '/admin'
      page.should have_content('Website Overview')
    end

    it "should be able to click the hompage link in sidebar" do
      visit '/admin'
      click_link 'admin-overview'
      page.should have_content('Website Overview')
    end

    it "should be able to go to the list of pages" do
      @page = Page.create(title: 'home-foo', content: 'foobar')
      visit '/admin'
      click_link 'admin-pages'
      page.should have_content('Website Pages')
      page.should have_content('home-foo')
      @page.destroy
    end

    it "should be able to go to the list of pages" do
      visit '/admin'
      click_link 'admin-users'
      page.should have_content('Administration Users')
    end

  end
end