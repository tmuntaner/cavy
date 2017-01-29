require 'spec_helper'

describe 'signed in client' do

  before(:each) do
    log_in('client')
  end

  after(:each) do
    log_out
  end

  it 'should allow the user to go to the admin page' do
    visit '/admin'
    expect(page).to have_content('Website Dashboard')
  end

  it 'should allow the user to go to the pages page' do
    visit '/admin'
    click_link 'admin-pages'
    expect(page).to have_content('Website Pages')
  end

end