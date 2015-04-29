class PagesController < ApplicationController
  def search
    query = params[:q]
    @pages = Page.search(query)
    render json: {query: query, results: @pages.as_json(methods: :url)}
  end
end
