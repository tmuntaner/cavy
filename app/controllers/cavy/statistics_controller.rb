require_dependency "cavy/application_controller"
require 'garb'

module Cavy
  class StatisticsController < ApplicationController

    before_action :login

    def visitor_history
      history = load_visitor_history
      
      if google_analytics_setup?
        render json: {
          type: 'AreaChart',
          cols: [['string','date'],['number', 'Page Visits']],
          rows: history,
          options: {
            title: 'Visits vs Day for Last 30 Days',
            legend: 'none',
            hAxis: {
              slantedText:true,
              showTextEvery: 2
            }
          }
        }
      else
        render json: {}
      end

    end

    def page_view_history
      history = build_page_view_history
      
      if google_analytics_setup?
        render json: {
          type: 'PieChart',
          cols: [['string','Path'],['number', 'Page Visits']],
          rows: history,
          options: {
            pieSliceText: 'none',
            title: 'Percentage of Page Visits for Last 30 Days',
          }
        }
      else
        render json: {}
      end
    end

    private

    def login
      @garb     ||= Garb::Session.login(Cavy.google_analytics_username,Cavy.google_analytics_password)
      @profile  ||= Garb::Management::Profile.all.detect { |p| p.web_property_id == Cavy.google_analytics_property_id}
    end

    def load_visitor_history
      Rails.cache.fetch('visitor_history', expires_in: 1.day) {
        result = []
        Cavy::PageViews.results(@profile).each do |r|
          result << ["#{r.day}.#{r.month}", r.pageviews.to_i]
        end
        result
      }
    end

    def load_page_data
      Rails.cache.fetch('page_data', expires_in: 1.day) {
        result = []
        Cavy::PageData.results(@profile).each do |r|
          result << [r.exits.to_i, r.pageviews.to_i, r.page_path]
        end
        result
      }
    end

    def build_page_view_history
      data = load_page_data
      
      history = Rails.cache.fetch('page_view_history', expires_in: 1.day) {
        result = []

        data.each do |r|
          result << [r[2], r[0]]
        end

        result
      }

      return history
    end


  end
end