require 'spec_helper'

module Cavy
  describe ViewHelpers do
    let(:dummy_class) { Class.new { extend Cavy::ViewHelpers } }

    describe 'page elements' do
      it 'gives a page element div' do
        element = dummy_class.page_element(id: 'title', content: 'foobar')
        expect(element).to eq("<div id='title'>foobar</div>")
      end

      it 'gives a localized page element div' do
        page = create(:cavy_page)
        page.update_elements(title: { en: 'foobar_en', de: 'foobar_de' })
        I18n.locale = :de
        element = dummy_class.localized_page_element(id: 'title', page: page)
        expect(element).to eq("<div id='title'>foobar_de</div>")
        I18n.locale = :en
        element = dummy_class.localized_page_element(id: 'title', page: page)
        expect(element).to eq("<div id='title'>foobar_en</div>")
      end
    end

    describe 'seo' do
      it 'gives proper seo tags for a page' do
        page = Cavy::Page.create(title: { en: 'foo bar', de: 'das foo bar' }, seo_keywords: { en: %w[ghost summer] }, seo_description: { en: 'first piggies' })
        element = dummy_class.meta_tags(page)
        expect(element).to eq("<meta content='first piggies' name='description'> <meta content='ghost, summer' name='keywords'>")
        page.destroy
      end
    end
  end
end
