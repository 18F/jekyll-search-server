class Page < ActiveRecord::Base
  searchkick
  
  def url
    base_url = Rails.configuration.jekyll_api_url
    "#{base_url}#{path}"
  end

end
