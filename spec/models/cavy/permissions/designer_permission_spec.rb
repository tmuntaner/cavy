require "spec_helper"

module Cavy
  describe Permissions::DesignerPermission do
    subject { Permissions.permission_for(build(:cavy_user, role: 'designer')) }

    it "allows anything" do
      expect allow(:any, :thing)
      expect allow_param(:any, :thing)
    end

  end
end
