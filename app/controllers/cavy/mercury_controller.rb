module Cavy
  class MercuryController < ActionController::Base

    protect_from_forgery
    before_filter :authenticate, :only => :edit
    layout false

    def edit
      render :text => '', :layout => 'mercury'
    end

    def resource
      render :action => "/#{params[:type]}/#{params[:resource]}"
    end

    def snippet_options
      @options = params[:options] || {}
      render :action => "/snippets/#{params[:name]}/options"
    end

    def snippet_preview
      render :action => "/snippets/#{params[:name]}/preview"
    end

    def test_page
      render :text => params
    end

    def image
      uploader = ImageUploader.new
      uploader.store!(params[:image][:image])
      # uploader.resize(params[:images])
      render json: {image: {url: uploader.url} }
    end

    private

    # def authenticate
    #   redirect_to "/#{params[:requested_uri]}" unless can_edit?
    # end
  end
end