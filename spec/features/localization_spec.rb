require 'spec_helper'

describe 'localizations' do

  # reset locales
  before(:each) do
    Cavy.config do |config|
      config.locales = [:en, :de]
      config.default_locale = :en
    end
    @user = FactoryGirl.create(:cavy_user, password: 'secret', password_confirmation: 'secret')
  end

  # reset locales
  after(:each) do
    Cavy.config do |config|
      config.locales = [:en, :de]
      config.default_locale = :en
    end
    @user.destroy
  end

  it 'should be able to set localizations' do
    Cavy.config do |config|
      config.locales = [:en, :de, :wk]
    end
    expect(I18n.available_locales).to eq([:en, :de, :wk])
  end

  it 'should be able to set default locale' do
    Cavy.config do |config|
      config.locales = [:en, :de, :wk]
      config.default_locale = :wk
    end
    I18n.default_locale = :wk
  end

  it 'should redirect to /wk if default_locale is set to wk when visiting root' do
    Cavy.config do |config|
      config.locales = [:en, :de, :wk]
      config.default_locale = :wk
    end

    @home = Cavy::Page.create(title: 'home')
    visit '/'
    expect(current_path).to eq('/wk/')
    @home.destroy
  end

  it 'should redirect to /wk/about if default_locale is set to wk when visiting /about' do
    Cavy.config do |config|
      config.locales = [:en, :de, :wk]
      config.default_locale = :wk
    end
    @about = Cavy::Page.create(title: 'about')
    visit '/about'
    expect(current_path).to eq('/wk/about')
    @about.destroy
  end

  it 'should redirect to / if only one locale when visiting root' do
    Cavy.config do |config|
      config.locales = %i[en]
    end
    @home = Cavy::Page.create(title: 'home')
    visit '/'
    expect(current_path).to eq('/')
    @home.destroy
  end

  it 'should redirect to /about if only one locale when visiting /about' do
    Cavy.config do |config|
      config.locales = %i[en]
    end
    @about = Cavy::Page.create(title: 'about')
    visit '/about'
    expect(current_path).to eq('/about')
    @about.destroy
  end
end