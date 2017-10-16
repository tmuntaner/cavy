require 'spec_helper'

module Cavy
  describe AdminPagesController, type: :request do
    describe 'admin/developer/designer user role' do
      before do
        I18n.locale = :en
        log_in('admin')
      end

      after do
        log_out
      end

      it 'is able to go to the new page page' do
        visit '/admin'
        click_link 'admin-pages'
        click_link 'admin-new-page'
        expect(page).to have_content('New Page')
      end

      it 'is able to add a new page' do
        @page_template = FactoryGirl.create(:cavy_page_template)
        visit '/admin'
        click_link 'admin-pages'
        click_link 'admin-new-page'
        fill_in 'page_title', with: 'foobar'
        select @page_template.name, from: :page_cavy_page_template_id
        click_on 'submit_page'
        @page = Cavy::Page.last
        expect(@page.cavy_page_template_id).to eq(@page_template.id)
        expect(@page.render).to eq(@page_template.template)
      end

      it 'is able to edit page settings' do
        @page = FactoryGirl.create(:cavy_page)
        @page_template = FactoryGirl.create(:cavy_page_template)
        expect(@page.render).not_to eq(@page_template.template)
        visit '/admin'
        click_link 'admin-pages'
        click_link "edit-page-#{@page.id}"
        fill_in 'page_tag_string', with: 'foo,bar'
        select @page_template.name, from: :page_cavy_page_template_id
        fill_in 'page_route', with: 'foos'
        fill_in 'page_seo_description_string', with: 'foo'
        click_on 'submit_page_settings'
        @page = Cavy::Page.find(@page.id)
        expect(@page.seo_keywords[I18n.locale.to_s]).to eq(%w[foo bar])
        expect(@page.route).to eq('foos')
        expect(@page.seo_description[I18n.locale.to_s]).to eq('foo')
        expect(@page.render).to eq(@page_template.template)
      end

      it 'is able to edit page content' do
        @page = FactoryGirl.create(:cavy_page)
        visit '/admin'
        click_link 'admin-pages'
        click_link "edit-page-#{@page.id}"
        Cavy.locales.try(:each) do |locale|
          fill_in "page[title][#{locale}]", with: "foobar #{locale}"
          fill_in "page[page_elements][content][#{locale}]", with: "foo #{locale}"
        end
        click_on 'submit_page_content'
        @page = Cavy::Page.find(@page.id)
        Cavy.locales.try(:each) do |locale|
          expect(@page.localized_title(locale)).to eq("foobar #{locale}")
          expect(@page.get_page_element('content', locale)).to eq("foo #{locale}")
        end
      end

      it 'is able to go to the list of pages' do
        @page = FactoryGirl.create(:cavy_page)
        visit '/admin'
        click_link 'admin-pages'
        expect(page).to have_content('Website Pages')
        expect(page).to have_content(@page.localized_title)
        @page.destroy
      end

      it 'is able to add data' do
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
      before do
        log_in_rack('client')
      end

      after do
        log_out
      end

      it 'does not allow a client to go to the new page route' do
        visit admin_new_page_path
        expect(page).to have_content('Please Sign In to Continue')
      end
    end
  end
end
