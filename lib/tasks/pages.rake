require 'json'
require 'pry'
require 'open-uri'

namespace :pages do
  desc "Crawls the pages"
  task crawl: :environment do
    old_pages = Page.all

    base_url = Rails.configuration.jekyll_api_url
    url = "#{base_url}/api/v1/pages.json"

    response_string = open(url).read
    response = JSON.parse(response_string)
    entries = response["entries"]

    entries.each do |entry|
      page = Page.new
      page.path = entry["url"]
      page.title = entry["title"]
      page.body = entry["body"]
      page.save
    end

    old_pages.each do |page|
      page.delete
    end
  end
end
