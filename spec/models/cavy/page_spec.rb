require 'spec_helper'

module Cavy
  describe Page do

    it "should be able to create a new page with title and content" do
      Page.create(title: 'foo', content: 'bar')
      @page = Page.find_by(title: 'foo')
      @page.should be_valid
      @page.destroy
    end

    it "should not be able to create two pages with same title" do
      @page1 = Page.create(title: 'foo', content: 'bar')
      @page2 = Page.create(title: 'foo', content: 'bar')
      @page2.should_not be_valid
    end

    it "should not allow the creation of a page without a title" do
      @page = Page.create(content: 'foobar')
      @page.should_not be_valid
    end

    it "should be able to have a title" do
      Page.create(title: 'foo', content: 'bar')
      @page = Page.find_by(title: 'foo')
      @page.title.should eq('foo')
      @page.destroy
    end

    it "should be able to have content" do
      Page.create(title: 'foo', content: 'bar')
      @page = Page.find_by(title: 'foo')
      @page.content.should eq('bar')
      @page.destroy
    end

    it "should be able to specify a render page" do
      Page.create(title: 'foo', content: 'bar', render: 'foobar')
      @page = Page.find_by(title: 'foo')
      @page.render.should eq('foobar')
      @page.destroy
    end

  end
end
