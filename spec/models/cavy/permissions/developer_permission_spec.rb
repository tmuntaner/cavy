require "spec_helper"

module Cavy
  describe Permissions::DeveloperPermission do
    subject { Permissions.permission_for(build(:cavy_user, role: 'developer')) }

    it "allows anything" do
      expect allow(:any, :thing)
      expect allow_param(:any, :thing)
    end

  end
end
