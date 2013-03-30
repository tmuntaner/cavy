require 'spec_helper'

describe 'localizations' do
  
  # reset locales
  before(:each) do
    Cavy.config do |config|
      config.locales = [:en,:de]
      config.default_locale = :en
    end
  end

  # reset locales
  after(:each) do
    Cavy.config do |config|
      config.locales = [:en,:de]
      config.default_locale = :en
    end
  end

  it "should be able to set localizations" do
    Cavy.config do |config|
      config.locales = [:en,:de, :wk]
    end
    I18n.available_locales.should eq([:en,:de, :wk])
  end

  it "should be able to set default locale" do
    Cavy.config do |config|
      config.locales = [:en,:de, :wk]
      config.default_locale = :wk
    end
    I18n.default_locale = :wk
  end

  it "should redirect to /wk if default_locale is set to wk when visiting root" do
    Cavy.config do |config|
      config.locales = [:en,:de, :wk]
      config.default_locale = :wk
    end
    @home = Cavy::Page.create(title: 'home', content: 'foo_about_bar')
    visit '/'
    current_path.should == '/wk/'
    @home.destroy
  end

  it "should redirect to /wk/about if default_locale is set to wk when visiting /about" do
    Cavy.config do |config|
      config.locales = [:en,:de, :wk]
      config.default_locale = :wk
    end
    @about = Cavy::Page.create(title: 'about', content: 'foo_about_bar')
    visit '/about'
    current_path.should == '/wk/about'
    @about.destroy
  end

  it "should redirect to / if only one locale when visiting root" do
    Cavy.config do |config|
      config.locales = :en
    end
    @home = Cavy::Page.create(title: 'home', content: 'foo_about_bar')
    visit '/'
    current_path.should == '/'
    @home.destroy
  end

  it "should redirect to /about if only one locale when visiting /about" do
    Cavy.config do |config|
      config.locales = :en
    end
    @about = Cavy::Page.create(title: 'about', content: 'foo_about_bar')
    visit '/about'
    current_path.should == '/about'
    @about.destroy
  end
end