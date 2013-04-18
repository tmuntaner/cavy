require 'spec_helper'

module Cavy
  describe ViewHelpers do
    describe 'page elements' do
      it 'should give a page element div' do
        element = page_element(id: 'title', content: 'foobar')
        element.should eq("<div id='title' data-mercury='full'>foobar</div>")
      end

      it 'should give a localized page element div' do
        page = create(:cavy_page)
        I18n.locale = :en
        page.update_elements('title_en' => {'value' => 'foobar_en'})
        I18n.locale = :de
        page.update_elements('title_de' => {'value' => 'foobar_de'})
        element = localized_page_element(id: 'title', page: page)
        element.should eq("<div id='title_de' data-mercury='full'>foobar_de</div>")
        I18n.locale = :en
        element = localized_page_element(id: 'title', page: page)
        element.should eq("<div id='title_en' data-mercury='full'>foobar_en</div>")
      end
    end
  end
end