require "spec_helper"

module Cavy
  describe Permissions::DeveloperPermission do
    subject { Permissions.permission_for(build(:cavy_user, role: 'developer')) }

    it "allows anything" do
      should allow(:any, :thing)
      should allow_param(:any, :thing)
    end

  end
end