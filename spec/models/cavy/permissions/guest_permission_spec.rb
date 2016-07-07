require 'spec_helper'

module Cavy
  describe Permissions::GuestPermission do
    subject { Permissions.permission_for(nil) }

    it 'allows admin pages' do
      expect(subject).not_to allow('cavy/admin_pages', :index)
      expect(subject).not_to allow('cavy/admin_pages', :show)
      expect(subject).not_to allow('cavy/admin_pages', :update)
      expect(subject).not_to allow('cavy/admin_pages', :edit)

      expect(subject).not_to allow('cavy/admin_pages', :new)
      expect(subject).not_to allow('cavy/admin_pages', :create)
      expect(subject).not_to allow('cavy/admin_pages', :delete)
    end

    it 'allows to view pages' do
      expect allow('cavy/pages', :page)
      expect(subject).not_to allow('cavy/pages', :edit)
      expect(subject).not_to allow('cavy/pages', :update)
    end

    it 'expect(subject).not_to allow sessions' do
      expect allow('cavy/sessions', :new)
      expect allow('cavy/sessions', :create)
      expect allow('cavy/sessions', :destroy)
    end

    it 'expect(subject).not_to allow admin panel' do
      expect(subject).not_to allow('cavy/admin', :overview)
      expect(subject).not_to allow('cavy/admin', :users)
      expect(subject).not_to allow('cavy/admin', :new_user)
    end

    it 'expect(subject).not_to allow mercury' do
      expect(subject).not_to allow('cavy/mercury', :edit)
      expect(subject).not_to allow('cavy/mercury', :resource)
      expect(subject).not_to allow('cavy/mercury', :snippet_options)
      expect(subject).not_to allow('cavy/mercury', :snippet_preview)
      expect(subject).not_to allow('cavy/mercury', :test_page)
      expect(subject).not_to allow('cavy/mercury', :image)
    end

    it 'expect(subject).not_to allow users' do
      expect(subject).not_to allow('cavy/users', :index)
      expect(subject).not_to allow('cavy/users', :show)
      expect(subject).not_to allow('cavy/users', :new)
      expect(subject).not_to allow('cavy/users', :edit)
      expect(subject).not_to allow('cavy/users', :create)
      expect(subject).not_to allow('cavy/users', :update)
    end

  end
end
