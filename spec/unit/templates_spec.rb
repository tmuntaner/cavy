require 'spec_helper'

describe Cavy::Templates do
  it 'provides a options array for select boxes' do
    options = [%w[string STRING], %w[text TEXT], %w[picture PICTURE]]
    expect(described_class.select_options).to eq(options)
  end

  describe 'get_option_value' do
    it 'gets value from option' do
      expect(described_class.get_option_value('string', 'type')).to eq('STRING')
    end

    it 'returns nil if option does not exist' do
      expect(described_class.get_option_value('foo', 'type')).to be_nil
    end

    it 'returns nil if option exists but field does not' do
      expect(described_class.get_option_value('string', 'foo')).to be_nil
    end
  end

  describe 'localize?' do
    it 'returns false if an option should not be localized' do
      expect(described_class.localize?('string')).to be_truthy
    end

    it 'returns true if an option should be localized' do
      expect(described_class.localize?('picture')).to be_falsey
    end
  end

end
