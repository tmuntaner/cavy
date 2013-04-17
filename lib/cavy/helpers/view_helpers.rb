module Cavy
  module ViewHelpers

    ##
    # This method makes a editable page element
    #
    #
    # = Example
    #
    #   page_element(id: 'title', content: @page.title)

    def page_element(opts) # :args: id, content
      "<div id='#{opts[:id]}' data-mercury='full'>#{opts[:content]}</div>".html_safe
    end

    ##
    # This method makes a localized editable page element
    #
    #
    # = Example
    #
    #   localized_page_element(id: 'title', page: @page)

    def localized_page_element(opts) # :args: id, page
      page_element(id: localized_title(opts[:id]), content: opts[:page].page_elements[localized_title(opts[:id])])
    end

    private

    def localized_title(id)
      "#{id}_#{I18n.locale}"
    end

  end
end