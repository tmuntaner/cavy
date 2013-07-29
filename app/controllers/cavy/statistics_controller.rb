require_dependency "cavy/application_controller"
require 'garb'

module Cavy
  class StatisticsController < ApplicationController

    before_action :login

    def page_views

      page_views = []
      Cavy::PageViews.results(@profile).each do |r|
        page_views << [r.day.to_i, r.pageviews.to_i]
      end

      if google_analytics_setup?
        
        render json: {
          type: 'AreaChart',
          cols: [['number','day'],['number', 'Page Visits']],
          rows: page_views,
          options: {
            chartArea: { width: '90%', height: '75%' },
            hAxis: { showTextEvery: 30 },
            legend: 'bottom'
          }
        }

        # render json: {
        #   "type" => "AreaChart",
        #   "cols" => [["number","day"],["number","visits"]],
        #   "rows" => [["01","0"],["02","9"],["03","1"],["04","0"],["05","5"],["06","2"],["07","8"],["08","0"],["09","9"],["10","34"],["11","20"],["12","2"],["13","5"],["14","5"],["15","4"],["16","1"],["17","1"],["18","14"],["19","11"],["20","0"],["21","7"],["22","3"],["23","2"],["24","0"],["25","2"],["26","3"],["27","5"],["28","2"],["29","7"],["29","0"],["30","0"]],
        #   "options" => {
        #     "chartArea"=>{"width" => "90%","height" => "75%"},
        #     "hAxis"=>{"showTextEvery" =>30},
        #     "legend" =>"bottom"}
        # }
      else
        render json: {
        }
      end

    end

    private

    def login
      @garb = Garb::Session.login(Cavy.google_analytics_username,Cavy.google_analytics_password)
      @profile = Garb::Management::Profile.all.detect { |p| p.web_property_id == Cavy.google_analytics_property_id}
    end

    def google_analytics_setup?
      if Cavy.google_analytics_username || Cavy.google_analytics_password || Cavy.google_analytics_property_id
        return true
      end
      return false
    end

  end
end