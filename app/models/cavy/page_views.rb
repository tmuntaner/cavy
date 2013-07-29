require 'garb'

module Cavy
  class PageViews
    
    extend Garb::Model

    metrics :pageviews
    dimensions :day, :month

  end
end