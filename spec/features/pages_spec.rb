require 'spec_helper'

module Cavy
  describe 'Pages' do

    before(:each) do
      I18n.locale = :en
      @page_template = FactoryGirl.create(:cavy_page_template, template: 'cavy/pages/page')
      @page = FactoryGirl.create(:cavy_page, title: {en: 'home', de: 'home'}, cavy_page_template: @page_template)
      @user = FactoryGirl.create(:cavy_user, password: 'secret', password_confirmation: 'secret')
    end

    after(:each) do
      @page.destroy
      @user.destroy
    end

    it 'should be able to go to the home page' do
      visit '/'
      expect(page).to have_content(@page.get_page_element('test'))
    end

    it 'should be able to click link to new page from home page' do
      @about = FactoryGirl.create(:cavy_page, title: {en: 'about', de: 'über'}, page_elements: {test_en: 'foo_about_bar', test_de: 'foo_über_bar'}, cavy_page_template: @page_template)
      visit '/'
      click_link 'about'
      expect(page).to have_content('foo_about_bar')
      @about.destroy
    end

    it 'should send the link for the root path back to the root when clicked' do
      visit '/'
      click_link 'home'
      expect(current_path).to eq('/en/')
    end

    it 'should render content with cavy/pages/render if no other render was specified' do
      visit '/'
      @page.update(render: '')
      expect(page).to have_content(@page.get_page_element('test'))
    end

    it 'should be able to change render' do
      @page.update(render: 'cavy/shared/test')
      visit '/'
      expect(page).to have_content(@page.localized_title)
    end

    it 'should be able to go to non-root page through url' do
      @about = Page.create(title: {en: 'about', de: 'über'}, page_elements: {test_en: 'foo_about_bar', test_de: 'foo_über_bar'}, cavy_page_template: @page_template)
      visit '/about'
      expect(page).to have_content('foo_about_bar')
      @about.destroy
    end

    it 'should be able to go to non-root page through url with spaces in title' do
      @about = Page.create(title: {en: 'about us', de: 'über uns'}, page_elements: {test_en: 'foo_about_bar', test_de: 'foo_über_bar'})
      visit '/about_us'
      expect(page).to have_content('foo_about_bar')
      @about.destroy
    end

    describe 'seo' do
      it 'should display the page description and meta tags' do
        @page = FactoryGirl.create(:cavy_page, title: {en: 'seo', de: 'das seo'}, seo_description: {en: 'guinea pigs are awesome'}, seo_keywords: {en: ['Ghost', 'Summer', 'Pumpkin Spice', 'Greywind']}, cavy_page_template: @page_template)
        visit "/#{@page.route}"
        page.find "meta[content='#{@page.seo_description['en']}']", visible: 'false'
        page.find "meta[content='#{@page.seo_keywords['en'].join(', ')}']", visible: 'false'
        @page.destroy
      end
    end

    it 'should give 404 for non pages' do
      visit '/supercalifragilisticexpialidocious'
      expect(page.status_code).to eq(404)
    end

  end
end
