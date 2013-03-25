module Cavy
  module PagesHelper

    def pages_path(page)
      if page == Cavy.root
        "/"
      else
        "/#{page}"
      end
    end

  end
end
