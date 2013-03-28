require "spec_helper"

module Cavy
  describe Permissions::DesignerPermission do
    subject { Permissions.permission_for(build(:cavy_user, role: 'designer')) }

    it "allows anything" do
      should allow(:any, :thing)
      should allow_param(:any, :thing)
    end

  end
end