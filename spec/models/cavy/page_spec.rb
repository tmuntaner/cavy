require 'spec_helper'

module Cavy
  describe Page do

    describe 'page elements' do
      it 'should be able to add page content' do
        I18n.locale = :en
        page = Cavy::Page.create(title: {en: 'foo bar', de: 'das foo bar'})
        elements = {title: {en: 'bar'}, content: 'foo', page: 'element'}
        page.update_elements(elements)
        page = Cavy::Page.find(page.id)
        expect(page.localized_title).to eq('foo bar')
        expect(page.get_page_element 'page').to eq('element')
      end
      it 'should not replace past page content when saving, just override' do
        I18n.locale = :en
        page = Cavy::Page.create({title: {en: 'foo bar', de: 'das foo bar'}, page_elements: {foo_en: 'foo'}})
        elements = {title: {en: 'bar'}, content: 'foo', bar: 'bar'}
        page.update_elements(elements)
        page = Cavy::Page.find(page.id)
        expect(page.localized_title).to eq('foo bar')
        expect(page.get_page_element 'foo').to eq('foo')
        expect(page.get_page_element 'bar').to eq('bar')
      end
    end

    describe 'title' do
      it 'should translate title' do
        I18n.locale = :en
        @page = Page.create(title: {en: 'home', de: 'Haus'})
        expect(Cavy::Page.find(@page.id).title[I18n.locale.to_s]).to eq('home')
        I18n.locale = :de
        Cavy::Page.find(@page.id).set_title 'Hause'
        expect(Cavy::Page.find(@page.id).title[I18n.locale.to_s]).to eq('Haus')
        I18n.locale = :en
        expect(Cavy::Page.find(@page.id).title[I18n.locale.to_s]).to eq('home')
      end

      it 'should be able to have a title' do
        Page.create(title: {en: 'foo', de: 'das foo'})
        @page = Page.last
        I18n.locale = :en
        expect(@page.title[I18n.locale.to_s]).to eq('foo')
        @page.destroy
      end
    end

    describe 'routes' do
      it 'should make a route after saving' do
        Page.create(title: {en: 'foo', de: 'das foo'})
        @page = Page.last
        expect(@page.route).to eq('foo')
        @page.destroy
      end

      it 'should take care of spaces in routes' do
        Page.create(title: {en: 'foo bar', de: 'das foo bar'})
        @page = Page.last
        expect(@page.route).to eq('foo_bar')
        @page.destroy
      end

      it 'should not be able to create two pages with the same route' do
        @page1 = Page.create(title: {en: 'foo bar', de: 'das foo bar'}, route: 'bar')
        @page2 = Page.create(title: {en: 'foo bar2', de: 'das foo bar2'}, route: 'bar')
        expect(@page2).not_to be_valid
      end
    end

    describe 'render' do
      it 'should be able to specify a render page' do
        Page.create(title: {en: 'foo bar', de: 'das foo bar'}, render: 'foobar')
        @page = Page.last
        expect(@page.render).to eq('foobar')
        @page.destroy
      end
    end

    describe 'seo' do
      describe 'tags' do
        it 'should accept no tag string' do
          @page = Page.create(title: {en: 'foo bar', de: 'das foo bar'}, tag_string: '')
          expect(@page).to be_valid
          @page.destroy
        end

        it 'should accept an string of tags' do
          @page = Page.create(title: {en: 'foo bar', de: 'das foo bar'}, tag_string: 'Ruby,Rainbows')
          expect(@page.seo_keywords[I18n.locale.to_s]).to eq(%w(Ruby Rainbows))
          expect(@page).to be_valid
          @page.destroy
        end
      end
      describe 'description' do
        it 'should allow a page to have a description' do
          @page = Page.create(title: {en: 'foo bar', de: 'das foo bar'}, seo_description: {en: 'foobar'})
          expect(@page.seo_description['en']).to eq('foobar')
          expect(@page).to be_valid
          @page.destroy
        end
        it 'should allow a page to have no description' do
          @page = Page.create(title: {en: 'foo bar', de: 'das foo bar'})
          expect(@page).to be_valid
          @page.destroy
        end
      end
    end

    describe 'data' do
      it 'should accept a hash of data' do
        @page = Page.create(title: {en: 'foo bar', de: 'das foo bar'}, data: {name: 'ruby rainbows'})
        expect(@page.data['name']).to eq('ruby rainbows')
      end

      it 'should accept a key and value to update data' do
        @page = Page.create(title: {en: 'foo bar', de: 'das foo bar'}, data: {name: 'ruby rainbows'})
        @page.set_key_value('foo', 'bar')
        expect(@page.data['foo']).to eq('bar')
        expect(@page.data['name']).to eq('ruby rainbows')
      end
    end

  end
end
