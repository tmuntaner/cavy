require 'spec_helper'

describe 'signed in client' do
  before do
    log_in('client')
  end

  after do
    log_out
  end

  it 'allows the user to go to the pages page' do
    visit '/admin'
    click_link 'admin-pages'
    expect(page).to have_content('Website Pages')
  end
end
