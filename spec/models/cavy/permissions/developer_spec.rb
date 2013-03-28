require "spec_helper"

module Cavy
  describe Permissions::DeveloperPermission do
    subject { Permissions.permission_for(build(:cavy_user, role: 'developer')) }

    it "allows admin pages" do
      should allow('cavy/admin_pages', :index)
      should allow('cavy/admin_pages', :show)
      should allow('cavy/admin_pages', :update)
      should allow('cavy/admin_pages', :edit)
      should allow('cavy/admin_pages', :new)
      should allow('cavy/admin_pages', :create)
      should allow('cavy/admin_pages', :delete)
    end

    it "allows to view pages" do
      should allow('cavy/pages', :page)
      should allow('cavy/pages', :edit)
      should allow('cavy/pages', :update)
    end

    it "should allow sessions" do
      should allow('cavy/sessions', :new)
      should allow('cavy/sessions', :create)
      should allow('cavy/sessions', :destroy)
    end

    it "should allow admin panel" do
      should allow('cavy/admin', :overview)
      should allow('cavy/admin', :users)
      should allow('cavy/admin', :new_user)
    end

    it "should allow mercury" do
      should allow('cavy/mercury', :edit)
      should allow('cavy/mercury', :resource)
      should allow('cavy/mercury', :snippet_options)
      should allow('cavy/mercury', :snippet_preview)
      should allow('cavy/mercury', :test_page)
      should allow('cavy/mercury', :image)
    end

    it "should allow users" do
      should allow('cavy/users', :index)
      should allow('cavy/users', :show)
      should allow('cavy/users', :new)
      should allow('cavy/users', :edit)
      should allow('cavy/users', :create)
      should allow('cavy/users', :update)
    end

  end
end