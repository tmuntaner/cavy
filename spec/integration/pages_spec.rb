require 'spec_helper'

module Cavy
  describe 'Pages' do

    before(:each) do
      @page = FactoryGirl.create(:cavy_page, title: 'home')
    end

    after(:each) do
      @page.destroy
    end

    it "should be able to go to the home page" do
      visit '/'
      page.should have_content(@page.content)
    end

    it "should be able to click link to new page from home page" do
      @about = Page.create(title: 'about', content: 'foo_about_bar')
      visit '/'
      click_link 'about'
      page.should have_content('foo_about_bar')
      @about.destroy
    end

    it "should send the link for the root path back to the root when clicked" do
      visit '/'
      click_link 'home'
      current_path.should == '/en/'
    end

    it "should render content with cavy/pages/render if no other render was specified" do
      visit '/'
      @page.update(render: '')
      page.should have_content(@page.content)
    end

    it "should be able to change render" do
      @page.update(render: 'cavy/shared/test')
      visit '/'
      page.should have_content(@page.title)
    end

    it "should be able to go to non-root page through url" do
      @about = Page.create(title: 'about', content: 'foo_about_bar')
      visit '/about'
      page.should have_content('foo_about_bar')
      @about.destroy
    end

    it "should be able to go to non-root page through url with spaces in title" do
      @about = Page.create(title: 'about us', content: 'foo_about_bar')
      visit '/about_us'
      page.should have_content('foo_about_bar')
      @about.destroy
    end

    describe 'edits' do
      it "should allow a signed in site manager to go to the edit page" do
        log_in('admin')
        @page = FactoryGirl.create(:cavy_page)
        visit cavy_edit_page_path({locale: :en, route: @page.route})
        page.should have_content('Back to Content')
        log_out
      end
      it "should not allow a signed in site manager to go to the edit page" do
        @page = FactoryGirl.create(:cavy_page)
        visit cavy_edit_page_path({locale: :en, route: @page.route})
        page.should_not have_content('Back to Content')
      end

      it "should allow the client to update the page" do
        log_in_rack('client')
        @page = FactoryGirl.create(:cavy_page)
        @parameters = { content: { title: {value: 'ghost'}, content: {value: 'foo-ghost-bar-summer'}}}
        post cavy_update_page_path({locale: :en, id: @page.id}), @parameters
        @page = Cavy::Page.find(@page.id)
        @page.title.should eq('ghost')
        @page.content.should eq('foo-ghost-bar-summer')
        @page.destroy
        log_out
      end
    end

    describe 'seo' do
      it 'should display the page desciption and meta tags' do
        @page = FactoryGirl.create(:cavy_page, title: 'seo', description: 'guinea pigs are awesome', tags: ['Ghost', 'Summer', 'Pumpkin Spice', 'Greywind'])
        visit "/#{@page.route}"
        page.find "meta[content='#{@page.description}']", visible: 'false'
        page.find "meta[content='#{@page.tags.join(', ')}']", visible: 'false'
        @page.destroy
      end
    end

    it "should give 404 for non pages" do
      visit '/supercalifragilisticexpialidocious'
      page.status_code.should eq(404)
    end

  end
end