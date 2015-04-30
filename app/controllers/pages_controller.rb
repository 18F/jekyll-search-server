class PagesController < ApplicationController
  def search
    query = params[:q]
    @pages = Page.search(query)
    render json: {results: @pages.map(&:to_hash)}
  end
end
