module Cavy
  module LinkHelpers

    ##
    # This method creates a page link for a cavy page
    #
    # = Example
    #
    #   cavy_page('home', 'home', active_check: true)

    def cavy_page(route, text, opts={active_check: true})
      href = ''
      active = false
      opts[:valid_routes] = [route] unless opts[:valid_routes]

      if route == Cavy.root
        href = I18n.available_locales.count > 1 ? "/#{params[:locale]}/" : '/'
      else
        href = I18n.available_locales.count > 1 ? "/#{params[:locale]}/#{route}" : "/#{route}"
      end

      opts[:valid_routes].each do |route|
        if link_active(route)
          active = true
          break
        end
      end

      html_class = active ? 'active' : nil
      html_id = opts[:id] ? opts[:id] : nil

      make_link(href, text, class: html_class, id: html_id)
    end

    private

    ##
    # This method creates a link from opts and and a href
    #
    # = Example
    #
    #   make_link('/home', text, class: 'active', id: 'link1')

    def make_link(href, text, opts={})
      "<a href='#{href}' #{build_html_class(opts[:class])} #{build_html_id(opts[:id])}> #{text} </a>".html_safe
    end

    def build_html_class(html_class)
      return "class='#{html_class}'" if html_class != nil
    end

    def build_html_id(html_id)
      return "id='#{html_id}'" if html_id != nil
    end

    ##
    # This method checks if a route is active
    #
    # = Example
    #
    #   link_active(route)

    def link_active(route)
      current_path = params[:route] || Cavy.root
      return true if params[:controller] == 'cavy/pages' and params[:action] == 'page' and current_path == route
      false
    end

  end
end