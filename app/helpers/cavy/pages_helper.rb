module Cavy
  module PagesHelper

    def pages_path(page)
      if page == Cavy.root
        "/"
      else
        "/#{page.title}"
      end
    end

  end
end
