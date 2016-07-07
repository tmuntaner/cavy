require 'spec_helper'

module Cavy
  describe Permissions::AdminPermission do
    subject { Permissions.permission_for(build(:cavy_user, role: 'admin')) }

    it 'allows anything' do
      expect allow(:any, :thing)
      expect allow_param(:any, :thing)
    end
  end
end
