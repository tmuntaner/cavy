module Cavy
  module ViewHelpers

    extend self

    ##
    # This method makes a editable page element
    #
    #
    # = Example
    #
    #   page_element(id: 'title', content: @page.title)
    def page_element(opts) # :args: id, content
      "<div id='#{opts[:id]}'>#{opts[:content]}</div>".html_safe
    end

    ##
    # This method makes a localized editable page element
    #
    #
    # = Example
    #
    #   localized_page_element(id: 'title', page: @page)
    def localized_page_element(opts) # :args: id, page
      page_element(id: opts[:id], content: localized_text(opts))
    end

    ##
    # This method gets a localized text
    #
    #
    # = Example
    #
    #   localized_text(id: 'title', page: @page)
    def localized_text(opts)
      opts[:page].get_page_element(opts[:id])
    end

    ##
    # This method gives the user SEO meta tags
    #
    # = Example
    #
    #   meta_tags(page)
    def meta_tags(page)
      "<meta content='#{page.seo_description.to_h[I18n.locale.to_s]}' name='description'> <meta content='#{page_tags(page)}' name='keywords'>".html_safe
    end

    ##
    # This method creates a chart tag for the charts api´
    #
    # = Example
    #
    #   chart_tag ('page_vies', 300, 300)
    def chart_tag (action, width=700, height=300, params = {})
      params[:format] ||= :json

      path = url_for controller: :statistics, action: action

      content_tag(:div, :'data-chart' => path, :style => "height: #{height}px;") do
        image_tag('', :size => '24x24', :class => 'spinner')
      end

    end

    private

    def page_tags(page)
      page.seo_keywords.to_h.empty? ? '' : page.seo_keywords[I18n.locale.to_s].to_a.join(', ')
    end

  end
end
