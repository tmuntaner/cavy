require_dependency "cavy/application_controller"

module Cavy
  class PagesController < ApplicationController

    before_action :set_page, only: [:show, :edit, :update, :destroy]

    def page
      @page = params[:title]? get_page(params[:title]) : Page.find_by(title: Cavy.root)
      render @page.render || 'cavy/pages/page'
    end


    # GET /pages
    def index
      @pages = Page.all
    end

    # GET /pages/1
    def show
    end

    # GET /pages/new
    def new
      @page = Page.new
    end

    # GET /pages/1/edit
    def edit
    end

    # POST /pages
    def create
      @page = Page.new(page_params)

      if @page.save
        redirect_to @page, notice: 'Page was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /pages/1
    def update
      if @page.update(page_params)
        redirect_to @page, notice: 'Page was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /pages/1
    def destroy
      @page.destroy
      redirect_to pages_url, notice: 'Page was successfully destroyed.'
    end

    private

      def not_found
        raise ActionController::RoutingError.new('Not Found')
      end

      def get_page(title)
        Page.find_by(title: title) || not_found
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_page
        @page = Page.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def page_params
        params.require(:page).permit(:content, :title)
      end
  end
end
