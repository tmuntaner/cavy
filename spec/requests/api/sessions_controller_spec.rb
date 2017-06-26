require 'spec_helper'

module Cavy::V1
  describe SessionsController do

    describe 'api' do
      before(:each) do
        @current_user = FactoryGirl.create(:cavy_user, role: 'admin')
        @token = Cavy::JsonWebToken.encode(user: @current_user.id)
      end

      it 'should login user' do
        post '/api/v1/session.json', params: {email: @current_user.email, password: 'foobar'}
        expect(json['status']).to eq('ok')
        expect(json['token']).to eq(@token)
      end

      it 'should not login user with invalid info' do
        post '/api/v1/session.json', params: {email: @current_user.email, password: 'foobar1'}
        expect(json['status']).to_not eq('ok')
        expect(json['token']).to_not eq(@token)
      end
    end

  end
end
