require 'spec_helper'

module Cavy
  describe ViewHelpers do

    let(:dummy_class) { Class.new { extend Cavy::ViewHelpers } }

    describe 'page elements' do
      it 'should give a page element div' do
        element = dummy_class.page_element(id: 'title', content: 'foobar')
        element.should eq("<div id='title' data-mercury='full'>foobar</div>")
      end

      it 'should give a localized page element div' do
        page = create(:cavy_page)
        I18n.locale = :en
        page.update_elements(title_en: {'value' => 'foobar_en'})
        I18n.locale = :de
        page.update_elements(title_de: {'value' => 'foobar_de'})
        element = dummy_class.localized_page_element(id: 'title', page: page)
        element.should eq("<div id='title_de' data-mercury='full'>foobar_de</div>")
        I18n.locale = :en
        element = dummy_class.localized_page_element(id: 'title', page: page)
        element.should eq("<div id='title_en' data-mercury='full'>foobar_en</div>")
      end
    end

    describe 'seo' do
      it 'should give proper seo tags for a page' do
        page = Cavy::Page.create(title: {en: 'foo bar', de: 'das foo bar'}, tags: %w(ghost summer), description: 'first piggies')
        element = dummy_class.meta_tags(page)
        element.should eq("<meta content='first piggies' name='description'> <meta content='ghost, summer' name='keywords'>")
        page.destroy
      end
    end

  end
end
