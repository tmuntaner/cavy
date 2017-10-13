# == Schema Information
#
# Table name: cavy_pages
#
#  id                    :integer          not null, primary key
#  title                 :hstore
#  data                  :hstore
#  render                :string
#  route                 :string
#  page_elements         :json
#  cavy_page_template_id :integer
#  seo_description       :hstore
#  seo_keywords          :jsonb
#

require 'spec_helper'

describe Cavy::Page do
  subject(:page) { create(:cavy_page) }

  before do
    I18n.locale = :en
  end

  describe 'page elements' do
    it 'is able to add page content' do
      elements = { title: { en: 'bar' }, content: 'foo', page: 'element' }
      page.update_elements(elements)
      expect(page.get_page_element('page')).to eq('element')
    end
  end

  describe 'title' do
    subject(:page) { create(:cavy_page, title: { en: 'Home', de: 'Haus' }) }

    it 'has a german title' do
      I18n.locale = :de
      expect(page.localized_title).to eq('Haus')
    end

    it 'has a english title' do
      expect(page.localized_title).to eq('Home')
    end
  end

  describe 'routes' do
    subject(:page) { create(:cavy_page, title: { en: 'foo', de: 'das foo' }) }

    it 'makes a route after saving' do
      expect(page.route).to eq('foo')
    end

    it 'takes care of spaces in routes' do
      page = create(:cavy_page, title: { en: 'foo bar', de: 'das foo bar' })
      expect(page.route).to eq('foo_bar')
    end

    it 'is not able to create two pages with the same route' do
      described_class.create(route: 'bar')
      page = described_class.create(route: 'bar')
      expect(page).not_to be_valid
    end
  end

  describe 'render' do
    it 'should be able to specify a render page' do
      described_class.create(title: { en: 'foo bar', de: 'das foo bar' },
                             render: 'foobar')
      @page = described_class.last
      expect(@page.render).to eq('foobar')
      @page.destroy
    end
  end

  describe 'seo' do
    describe 'tags' do
      it 'should accept no tag string' do
        @page = described_class.create(title: { en: 'foo bar', de: 'das foo bar' },
                                       tag_string: '')
        expect(@page).to be_valid
        @page.destroy
      end

      it 'should accept an string of tags' do
        @page = described_class.create(title: { en: 'foo bar', de: 'das foo bar' },
                                       tag_string: 'Ruby,Rainbows')
        expect(@page.seo_keywords[I18n.locale.to_s]).to eq(%w[Ruby Rainbows])
        expect(@page).to be_valid
        @page.destroy
      end
    end
    describe 'description' do
      it 'should allow a page to have a description' do
        @page = described_class.create(title: { en: 'foo bar', de: 'das foo bar' },
                                       seo_description: { en: 'foobar' })
        expect(@page.seo_description['en']).to eq('foobar')
        expect(@page).to be_valid
        @page.destroy
      end
      it 'should allow a page to have no description' do
        @page = described_class.create(title: { en: 'foo bar', de: 'das foo bar' })
        expect(@page).to be_valid
        @page.destroy
      end
    end
  end

  describe 'data' do
    it 'should accept a hash of data' do
      @page = described_class.create(title: { en: 'foo bar', de: 'das foo bar' },
                                     data: { name: 'ruby rainbows' })
      expect(@page.data['name']).to eq('ruby rainbows')
    end

    it 'should accept a key and value to update data' do
      @page = described_class.create(title: { en: 'foo bar', de: 'das foo bar' },
                                     data: { name: 'ruby rainbows' })
      @page.set_key_value('foo', 'bar')
      expect(@page.data['foo']).to eq('bar')
      expect(@page.data['name']).to eq('ruby rainbows')
    end
  end
end
