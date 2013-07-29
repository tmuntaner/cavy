require 'garb'

module Cavy
  class PageData
    
    extend Garb::Model

    metrics :exits, :pageviews
    dimensions :page_path

  end
end