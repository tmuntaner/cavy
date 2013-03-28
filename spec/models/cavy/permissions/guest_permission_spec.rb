require "spec_helper"

module Cavy
  describe Permissions::GuestPermission do
    subject { Permissions.permission_for(nil) }

    it "allows admin pages" do
      should_not allow('cavy/admin_pages', :index)
      should_not allow('cavy/admin_pages', :show)
      should_not allow('cavy/admin_pages', :update)
      should_not allow('cavy/admin_pages', :edit)

      should_not allow('cavy/admin_pages', :new)
      should_not allow('cavy/admin_pages', :create)
      should_not allow('cavy/admin_pages', :delete)
    end

    it "allows to view pages" do
      should allow('cavy/pages', :page)
      should_not allow('cavy/pages', :edit)
      should_not allow('cavy/pages', :update)
    end

    it "should_not allow sessions" do
      should allow('cavy/sessions', :new)
      should allow('cavy/sessions', :create)
      should allow('cavy/sessions', :destroy)
    end

    it "should_not allow admin panel" do
      should_not allow('cavy/admin', :overview)
      should_not allow('cavy/admin', :users)
      should_not allow('cavy/admin', :new_user)
    end

    it "should_not allow mercury" do
      should_not allow('cavy/mercury', :edit)
      should_not allow('cavy/mercury', :resource)
      should_not allow('cavy/mercury', :snippet_options)
      should_not allow('cavy/mercury', :snippet_preview)
      should_not allow('cavy/mercury', :test_page)
      should_not allow('cavy/mercury', :image)
    end

    it "should_not allow users" do
      should_not allow('cavy/users', :index)
      should_not allow('cavy/users', :show)
      should_not allow('cavy/users', :new)
      should_not allow('cavy/users', :edit)
      should_not allow('cavy/users', :create)
      should_not allow('cavy/users', :update)
    end

  end
end