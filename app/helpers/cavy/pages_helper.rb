module Cavy
  module PagesHelper

    def pages_path(page)
      if page == Cavy.root
        I18n.available_locales.count > 1 ? "/#{params[:locale]}/" : '/'
      else
        I18n.available_locales.count > 1 ? "/#{params[:locale]}/#{page}" : "/#{page}"
      end
    end

    ##
    # This method makes a editable page element
    #
    # :args: id, content
    #
    # = Example
    #
    #   page_element(id: 'title', content: @page.title)

    def page_element(opts)
      "<div id='#{opts[:id]}' data-mercury='full'>#{opts[:content]}</div>".html_safe
    end

    ##
    # This method makes a localized editable page element
    #
    # :args: id, page
    #
    # = Example
    #
    #   localized_page_element(id: 'title', page: @page)

    def localized_page_element(opts)
      page_element(id: localized_title(opts[:id]), content: opts[:page].page_elements[localized_title(opts[:id])])
    end

    private

    def localized_title(id)
      "#{id}_#{I18n.locale}"
    end

  end
end
