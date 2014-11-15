require 'spec_helper'

module Cavy
  describe Page do

    describe 'page elements' do
      it 'should be able to add page content' do
        I18n.locale = :en
        page = Cavy::Page.create(title: {en: 'foo bar', de: 'das foo bar'}, content: {en: 'bar', de: 'das bar'})
        elements = {title: 'bar', content: 'foo', 'page' => {'value' => 'element'}}
        page.update_elements(elements)
        page = Cavy::Page.find(page.id)
        page.localized_title.should eq('foo bar')
        page.localized_content.should eq('bar')
        page.page_elements['page'].should eq('element')
      end
      it 'should not replace past page content when saving, just override' do
        I18n.locale = :en
        page = Cavy::Page.create(title: {en: 'foo bar', de: 'das foo bar'}, content: {en: 'bar', de: 'das bar'}, page_elements: {'foo' => 'foo'})
        elements = {title: 'bar', content: 'foo', 'bar' => {'value' => 'bar'}}
        page.update_elements(elements)
        page = Cavy::Page.find(page.id)
        page.localized_title.should eq('foo bar')
        page.localized_content.should eq('bar')
        page.page_elements['foo'].should eq('foo')
        page.page_elements['bar'].should eq('bar')
      end
    end

    describe 'title' do
      it 'should translate title' do
        I18n.locale = :en
        @page = Page.create(title: {en: 'home', de: 'Haus'}, content: 'bar')
        Cavy::Page.find(@page.id).title[I18n.locale.to_s].should eq('home')
        I18n.locale = :de
        Cavy::Page.find(@page.id).set_title 'Hause'
        Cavy::Page.find(@page.id).title[I18n.locale.to_s].should eq('Haus')
        I18n.locale = :en
        Cavy::Page.find(@page.id).title[I18n.locale.to_s].should eq('home')
      end

      it 'should be able to have a title' do
        Page.create(title: {en: 'foo', de: 'das foo'}, content: {en: 'bar', de: 'das bar'})
        @page = Page.last
        I18n.locale = :en
        @page.title[I18n.locale.to_s].should eq('foo')
        @page.destroy
      end
    end

    describe 'routes' do
      it 'should make a route after saving' do
        Page.create(title: {en: 'foo', de: 'das foo'}, content: {en: 'bar', de: 'das bar'})
        @page = Page.last
        @page.route.should eq('foo')
        @page.destroy
      end

      it 'should take care of spaces in routes' do
        Page.create(title: {en: 'foo bar', de: 'das foo bar'}, content: {en: 'bar', de: 'das bar'})
        @page = Page.last
        @page.route.should eq('foo_bar')
        @page.destroy
      end

      it 'should not be able to create two pages with the same route' do
        @page1 = Page.create(title: {en: 'foo bar', de: 'das foo bar'}, route: 'bar')
        @page2 = Page.create(title: {en: 'foo bar2', de: 'das foo bar2'}, route: 'bar')
        @page2.should_not be_valid
      end
    end

    describe 'content' do
      it 'should translate content' do
        I18n.locale = :en
        @page = Page.create(title: {en: 'foo bar', de: 'das foo bar'}, content: {en: 'bar', de: 'das bar'})
        @page.localized_content.should eq('bar')
        I18n.locale = :de
        @page.set_content('foo')
        @page.localized_content.should eq('foo')
        I18n.locale = :en
        @page.localized_content.should eq('bar')
      end

      it 'should be able to have content' do
        Page.create(title: {en: 'foo bar', de: 'das foo bar'}, content: {en: 'bar', de: 'das bar'})
        @page = Page.last
        I18n.locale = :en
        @page.localized_content.should eq('bar')
        @page.destroy
      end
    end

    describe 'render' do
      it 'should be able to specify a render page' do
        Page.create(title: {en: 'foo bar', de: 'das foo bar'}, content: 'bar', render: 'foobar')
        @page = Page.last
        @page.render.should eq('foobar')
        @page.destroy
      end
    end

    describe 'seo' do
      describe 'tags' do
        it 'should accept no tags' do
          @page = Page.create(title: {en: 'foo bar', de: 'das foo bar'}, tags: [])
          @page.should be_valid
          @page.destroy
        end

        it 'should accept no tag string' do
          @page = Page.create(title: {en: 'foo bar', de: 'das foo bar'}, tag_string: '')
          @page.should be_valid
          @page.destroy
        end

        it 'should accept an array of tags' do
          @page = Page.create(title: {en: 'foo bar', de: 'das foo bar'}, tags: ['Ruby', 'Rainbows'])
          @page.tags.should eq(['Ruby','Rainbows'])
          @page.should be_valid
          @page.destroy
        end

        it 'should accept an string of tags' do
          @page = Page.create(title: {en: 'foo bar', de: 'das foo bar'}, tag_string: 'Ruby,Rainbows')
          @page.tags.should eq(['Ruby','Rainbows'])
          @page.should be_valid
          @page.destroy
        end
      end
      describe 'description' do
        it "should allow a page to have a description" do
          @page = Page.create(title: {en: 'foo bar', de: 'das foo bar'}, description: 'foobar')
          @page.description.should eq('foobar')
          @page.should be_valid
          @page.destroy
        end
        it "should allow a page to have no description" do
          @page = Page.create(title: {en: 'foo bar', de: 'das foo bar'}, description: '')
          @page.should be_valid
          @page.destroy
        end
      end
    end

    describe 'data' do
      it 'should accept a hash of data' do
        @page = Page.create(title: {en: 'foo bar', de: 'das foo bar'}, data: {name: 'ruby rainbows'})
        @page.data['name'].should eq('ruby rainbows')
      end

      it 'should accept a key and value to update data' do
        @page = Page.create(title: {en: 'foo bar', de: 'das foo bar'}, data: {name: 'ruby rainbows'})
        @page.set_key_value('foo','bar')
        @page.data['foo'].should eq('bar')
        @page.data['name'].should eq('ruby rainbows')
      end
    end

  end
end
