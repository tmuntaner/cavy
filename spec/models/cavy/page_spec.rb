require 'spec_helper'

module Cavy
  describe Page do

    describe 'page elements' do
      it 'should be able to add page content' do
        page = Cavy::Page.create(title: 'foo', content: 'bar')
        elements = {title: 'bar', content: 'foo', 'page' => {'value' => 'element'}}
        page.update_elements(elements)
        page = Cavy::Page.find(page.id)
        page.title.should eq('foo')
        page.content.should eq('bar')
        page.page_elements['page'].should eq('element')
      end
      it 'should not replace past page content when saving, just override' do
        page = Cavy::Page.create(title: 'foo', content: 'bar', page_elements: {'foo' => 'foo'})
        elements = {title: 'bar', content: 'foo', 'bar' => {'value' => 'bar'}}
        page.update_elements(elements)
        page = Cavy::Page.find(page.id)
        page.title.should eq('foo')
        page.content.should eq('bar')
        page.page_elements['foo'].should eq('foo')
        page.page_elements['bar'].should eq('bar')
      end
    end

    describe 'title' do
      it 'should not accept a blank string as a title' do
        @page = Page.create(title: '', content: 'bar')
        @page.should_not be_valid
      end

      it 'should translate title' do
        I18n.locale = :en
        @page = Page.create(title: 'home', content: 'bar')
        Cavy::Page.find(@page.id).title.should eq('home')
        I18n.locale = :de
        Cavy::Page.find(@page.id).update_attributes(title: 'Haus')
        Cavy::Page.find(@page.id).title.should eq('Haus')
        I18n.locale = :en
        Cavy::Page.find(@page.id).title.should eq('home')
      end

      it 'should have a limit of 100 characters for a title' do
        @title = 'a'*100
        @page = Page.create(title: '', content: 'bar')
        @page.should_not be_valid
      end

      it 'should not accept a title over 100 characters' do
        @title = 'a'*101
        @page = Page.create(title: '', content: 'bar')
        @page.should_not be_valid
      end

      it 'should not allow the creation of a page without a title' do
        @page = Page.new(title: '', content: 'foobar')
        @page.should_not be_valid
      end

      it 'should be able to have a title' do
        Page.create(title: 'foo', content: 'bar')
        @page = Page.find_by(title: 'foo')
        @page.title.should eq('foo')
        @page.destroy
      end
    end

    describe 'routes' do
      it 'should make a route after saving' do
        @page = Page.create(title: 'foo', content: 'bar')
        @page.route.should eq('foo')
        @page.destroy
      end

      it 'should take care of spaces in routes' do
        Page.create(title: 'foo bar', content: 'bar')
        @page = Page.find_by(title: 'foo bar')
        @page.route.should eq('foo_bar')
        @page.destroy
      end

      it 'should not be able to create two pages with same title' do
        @page1 = Page.create(title: 'foo', content: 'bar')
        @page2 = Page.create(title: 'foo', content: 'bar')
        @page2.should_not be_valid
      end

      it 'should not be able to create two pages with the same route' do
        @page1 = Page.create(title: 'foo', route: 'bar')
        @page2 = Page.create(title: 'foo2', route: 'bar')
        @page2.should_not be_valid
      end
    end

    describe 'content' do
      it 'should translate content' do
        I18n.locale = :en
        @page = Page.create(title: 'home', content: 'bar')
        Cavy::Page.find(@page.id).content.should eq('bar')
        I18n.locale = :de
        Cavy::Page.find(@page.id).update_attributes(content: 'foo')
        Cavy::Page.find(@page.id).content.should eq('foo')
        I18n.locale = :en
        Cavy::Page.find(@page.id).content.should eq('bar')
      end
      it 'should be able to have content' do
        Page.create(title: 'foo', content: 'bar')
        @page = Page.find_by(title: 'foo')
        @page.content.should eq('bar')
        @page.destroy
      end
    end

    describe 'render' do
      it 'should be able to specify a render page' do
        Page.create(title: 'foo', content: 'bar', render: 'foobar')
        @page = Page.find_by(title: 'foo')
        @page.render.should eq('foobar')
        @page.destroy
      end
    end

    describe 'seo' do
      describe 'tags' do
        it 'should accept no tags' do
          @page = Page.create(title: 'foo', tags: [])
          @page.should be_valid
          @page.destroy
        end

        it 'should accept no tag string' do
          @page = Page.create(title: 'foo', tag_string: '')
          @page.should be_valid
          @page.destroy
        end

        it 'should accept an array of tags' do
          @page = Page.create(title: 'foo', tags: ['Ruby', 'Rainbows'])
          @page.tags.should eq(['Ruby','Rainbows'])
          @page.should be_valid
          @page.destroy
        end

        it 'should accept an string of tags' do
          @page = Page.create(title: 'foo', tag_string: 'Ruby,Rainbows')
          @page.tags.should eq(['Ruby','Rainbows'])
          @page.should be_valid
          @page.destroy
        end
      end
      describe 'description' do
        it "should allow a page to have a description" do
          @page = Page.create(title: 'foo', description: 'foobar')
          @page.description.should eq('foobar')
          @page.should be_valid
          @page.destroy
        end
        it "should allow a page to have no description" do
          @page = Page.create(title: 'foo', description: '')
          @page.should be_valid
          @page.destroy
        end
      end
    end

    describe 'data' do
      it 'should accept a hash of data' do
        @page = Page.create(title: 'test', data: {name: 'ruby rainbows'})
        @page.data[:name].should eq('ruby rainbows')
      end

      it 'should accept a key and value to update data' do
        @page = Page.create(title: 'test', data: {name: 'ruby rainbows'})
        @page.set_key_value('foo','bar')
        @page.data['foo'].should eq('bar')
        @page.data[:name].should eq('ruby rainbows')
      end
    end

  end
end
