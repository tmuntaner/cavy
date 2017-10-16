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
    subject(:page) { create(:cavy_page, route: '/foobar') }

    it 'makes a route after saving from title' do
      page = create(:cavy_page, title: { en: 'foo' })
      expect(page.route).to eq('foo')
    end

    it 'takes care of spaces in routes' do
      page = create(:cavy_page, title: { en: 'foo bar', de: 'das foo bar' })
      expect(page.route).to eq('foo_bar')
    end

    it 'is able to create two pages with different routes' do
      page = described_class.create(route: 'foo2')
      expect(page).to be_valid
    end

    it 'is not able to create two pages with the same route' do
      page.save
      new_page = described_class.create(route: '/foobar')
      expect(new_page).not_to be_valid
    end
  end

  describe 'seo' do
    describe 'tags' do
      subject(:page) { create(:cavy_page, tag_string: 'Ruby,Rainbows') }

      it 'accepts an empty tag string' do
        page = described_class.create(tag_string: '')
        expect(page).to be_valid
      end

      it 'accepts an string of tags' do
        expect(page.seo_keywords[I18n.locale.to_s]).to eq(%w[Ruby Rainbows])
      end
    end

    describe 'description' do
      subject(:page) { create(:cavy_page, seo_description: { en: 'foobar' }) }

      it 'has a seo have a description' do
        expect(page.seo_description['en']).to eq('foobar')
      end

      it 'is allowed to have no description' do
        page = create(:cavy_page, seo_description: '')
        expect(page).to be_valid
      end
    end
  end

  describe 'data' do
    subject(:page) { create(:cavy_page, data: { name: 'ruby rainbows' }) }

    it 'accepts a key and value to update data' do
      page.set_key_value('foo', 'bar')
      expect(page.data['foo']).to eq('bar')
    end

    it 'does not override data' do
      page.set_key_value('foo', 'bar')
      expect(page.data['name']).to eq('ruby rainbows')
    end
  end
end
