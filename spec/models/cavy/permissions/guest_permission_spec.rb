require 'spec_helper'

module Cavy
  describe Permissions::GuestPermission do
    subject(:permission) { Permissions.permission_for(nil) }

    it 'allows admin pages' do
      expect(permission).not_to allow('cavy/admin_pages', :index)
      expect(permission).not_to allow('cavy/admin_pages', :show)
      expect(permission).not_to allow('cavy/admin_pages', :update)
      expect(permission).not_to allow('cavy/admin_pages', :edit)

      expect(permission).not_to allow('cavy/admin_pages', :new)
      expect(permission).not_to allow('cavy/admin_pages', :create)
      expect(permission).not_to allow('cavy/admin_pages', :delete)
    end

    it 'allows to view pages' do
      expect allow('cavy/pages', :page)
      expect(permission).not_to allow('cavy/pages', :edit)
      expect(permission).not_to allow('cavy/pages', :update)
    end

    it 'expect(permission).not_to allow sessions' do
      expect allow('cavy/sessions', :new)
      expect allow('cavy/sessions', :create)
      expect allow('cavy/sessions', :destroy)
    end

    it 'expect(permission).not_to allow admin panel' do
      expect(permission).not_to allow('cavy/admin', :overview)
      expect(permission).not_to allow('cavy/admin', :users)
      expect(permission).not_to allow('cavy/admin', :new_user)
    end

    it 'expect(permission).not_to allow mercury' do
      expect(permission).not_to allow('cavy/mercury', :edit)
      expect(permission).not_to allow('cavy/mercury', :resource)
      expect(permission).not_to allow('cavy/mercury', :snippet_options)
      expect(permission).not_to allow('cavy/mercury', :snippet_preview)
      expect(permission).not_to allow('cavy/mercury', :test_page)
      expect(permission).not_to allow('cavy/mercury', :image)
    end

    it 'expect(permission).not_to allow users' do
      expect(permission).not_to allow('cavy/users', :index)
      expect(permission).not_to allow('cavy/users', :show)
      expect(permission).not_to allow('cavy/users', :new)
      expect(permission).not_to allow('cavy/users', :edit)
      expect(permission).not_to allow('cavy/users', :create)
      expect(permission).not_to allow('cavy/users', :update)
    end
  end
end
