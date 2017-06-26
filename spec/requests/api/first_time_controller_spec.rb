require 'spec_helper'

module Cavy::V1
  describe FirstTimeController do


    it 'should not get first time when it is not actually the first time' do
      @current_user = FactoryGirl.create(:cavy_user, role: 'admin')
      get '/api/v1/first_time.json', {}
      expect(json['status']).to eq('ok')
      expect(json['first_time']).to eq('false')
    end

    it 'should get first time when it is' do
      get '/api/v1/first_time.json', {}
      expect(json['status']).to eq('ok')
      expect(json['first_time']).to eq('true')
    end

  end
end
