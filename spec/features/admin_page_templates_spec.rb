require 'spec_helper'

module Cavy
  describe AdminPageTemplatesController, type: :request do

    before(:each) do
      I18n.locale = :en
      log_in('admin')
    end

    after(:each) do
      log_out
    end

    it 'should be able to go to the new page template page' do
      visit '/admin'
      click_link 'admin-page-templates'
      click_link 'admin-new-page-template'
      expect(page).to have_content('New Page Template')
    end

    describe 'page templates' do
      before (:each) do
        visit '/admin'
        click_link 'admin-page-templates'
        click_link 'admin-new-page-template'
        fill_in 'page_template_name', with: 'foobar'
        fill_in 'page_template_template', with: 'cavy_test/pages/test'
        click_button 'add'
        expect(Cavy::PageTemplate.count).to eq(1)
        @page_template = Cavy::PageTemplate.last
        expect(@page_template.name).to eq('foobar')
        expect(@page_template.template).to eq('cavy_test/pages/test')
      end

      it 'should be able to add a new page template' do
        expect(@page_template.template).to eq('cavy_test/pages/test')
      end

      it 'should be able to add edit page template' do
        visit '/admin'
        click_link 'admin-page-templates'
        click_link "edit-page-template-#{@page_template.id}"
        fill_in 'page_template_name', with: 'foobar1'
        fill_in 'page_template_template', with: 'cavy_test/pages/test1'
        click_button 'add'
        @page_template = Cavy::PageTemplate.last
        expect(@page_template.name).to eq('foobar1')
        expect(@page_template.template).to eq('cavy_test/pages/test1')
      end

      it 'should be able to delete page template' do
        visit '/admin'
        click_link 'admin-page-templates'
        click_link "delete-page-template-#{@page_template.id}"
        expect(Cavy::PageTemplate.count).to eq(0)
      end

      describe 'page template fields' do
        before(:each) do
          expect(@page_template.fields.nil?).to be_truthy
          visit '/admin'
          click_link 'admin-page-templates'
          click_link "edit-page-template-#{@page_template.id}"
          fill_in 'name', with: 'foobar'
          select 'string', from: 'type'
          click_button 'submit'
          @page_template = Cavy::PageTemplate.last
          expect(@page_template.fields.nil?).to be_falsey
          expect(@page_template.fields.empty?).to be_falsey
          expect(@page_template.fields['foobar']).to eq('STRING')
        end

        it 'should be able to delete page template field' do
          visit '/admin'
          click_link 'admin-page-templates'
          click_link "edit-page-template-#{@page_template.id}"
          expect(@page_template.fields.empty?).to be_falsey
          click_link "delete-#{@page_template.id}-foobar"
          @page_template = Cavy::PageTemplate.last
          expect(@page_template.fields.empty?).to be_truthy
        end

        it 'should be able to update page template field' do
          visit '/admin'
          click_link 'admin-page-templates'
          click_link "edit-page-template-#{@page_template.id}"
          expect(@page_template.fields['foobar']).to eq('STRING')
          select 'text', from: 'type-foobar'
          click_button 'submit-foobar'
          @page_template = Cavy::PageTemplate.last
          expect(@page_template.fields.empty?).to be_falsey
          expect(@page_template.fields['foobar']).to eq('TEXT')
        end
      end
    end

  end
end
