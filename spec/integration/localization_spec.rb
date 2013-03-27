require 'spec_helper'

describe 'localizations' do
  
  it "should be able to set localizations" do
    Cavy.config do |config|
      config.locales = [:en,:de]
    end
    I18n.available_locales.should eq([:en,:de])
  end

end