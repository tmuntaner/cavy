module Cavy
  module PagesHelper

    def pages_path(page)
      if page == Cavy.root
        I18n.available_locales.count > 1 ? "/#{params[:locale]}/" : '/'
      else
        I18n.available_locales.count > 1 ? "/#{params[:locale]}/#{page}" : "/#{page}"
      end
    end

  end
end
