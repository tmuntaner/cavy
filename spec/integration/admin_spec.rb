require 'spec_helper'

module Cavy
  describe 'Admin Interface' do

    before(:each) do
      log_in('admin')
    end

    after(:each) do
      log_out
    end
    
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
      visit '/admin'
      click_link 'admin-users'
      page.should have_content('Administration Users')
    end

  end
end