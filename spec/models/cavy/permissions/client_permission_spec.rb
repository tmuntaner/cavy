require 'spec_helper'

module Cavy
  describe Permissions::ClientPermission do
    subject(:permission) { Permissions.permission_for(build(:cavy_user, role: 'client')) }

    it 'allows admin pages' do
      expect allow('cavy/admin_pages', :index)
      expect allow('cavy/admin_pages', :show)
      expect allow('cavy/admin_pages', :update)
      expect allow('cavy/admin_pages', :edit)

      expect(permission).not_to allow('cavy/admin_pages', :new)
      expect(permission).not_to allow('cavy/admin_pages', :create)
      expect(permission).not_to allow('cavy/admin_pages', :delete)
      expect(permission).not_to allow_param(:page, :route)
      expect(permission).not_to allow_param(:page, :render)
    end

    it 'allows to view pages' do
      expect allow('cavy/pages', :page)
      expect allow('cavy/pages', :edit)
      expect allow('cavy/pages', :update)
    end

    it 'expect allow sessions' do
      expect allow('cavy/sessions', :new)
      expect allow('cavy/sessions', :create)
      expect allow('cavy/sessions', :destroy)
    end

    it 'expect allow admin panel' do
      expect allow('cavy/admin', :dashboard)
      expect allow('cavy/admin', :users)
      expect allow('cavy/admin', :new_user)
    end

    it 'expect allow mercury' do
      expect allow('cavy/mercury', :edit)
      expect allow('cavy/mercury', :resource)
      expect allow('cavy/mercury', :snippet_options)
      expect allow('cavy/mercury', :snippet_preview)
      expect allow('cavy/mercury', :test_page)
      expect allow('cavy/mercury', :image)
    end

    it 'expect allow users' do
      expect allow('cavy/users', :index)
      expect allow('cavy/users', :show)
      expect allow('cavy/users', :new)
      expect allow('cavy/users', :edit)
      expect allow('cavy/users', :create)
      expect allow('cavy/users', :update)
    end
  end
end
