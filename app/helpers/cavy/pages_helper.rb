module Cavy
  module PagesHelper
    def pages_path(page)
      I18n.available_locales.count > 1 ? "/#{params[:locale]}#{page}" : "#{page}"
    end
  end
end
