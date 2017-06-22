require 'spec_helper'

module Cavy
  describe AdminPagesController do

    describe 'api' do
      before(:each) do
        @current_user = FactoryGirl.create(:cavy_user, role: 'admin')
        @token = Cavy::JsonWebToken.encode(user: @current_user.id)
        @page_template = FactoryGirl.create(:cavy_page_template, template: 'cavy/pages/page')
        @page = FactoryGirl.create(:cavy_page,
                                   title: { en: 'home', de: 'home' },
                                   cavy_page_template: @page_template)
      end

      it 'should give unauthorized for non-api-user' do
        get '/api/v1/pages.json'
        expect(json['status']).to eq('unauthorized')
      end

      it 'should allow a user to communicate with the api' do
        get '/api/v1/pages.json', params: {}, headers: {
          HTTP_AUTHORIZATION: "Bearer #{@token}"
        }
        expect(json['status']).not_to eq('unauthorized')
        expect(json['pages']).not_to eq([])
        expect(json['pages'][0]['id']).to eq(@page.id)
        expect(json['pages'][0]['title']).to eq(@page.title)
        expect(json['pages'][0]['route']).to eq(@page.route)
      end
    end

  end
end
