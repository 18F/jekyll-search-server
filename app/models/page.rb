require 'elasticsearch/persistence/model'

class Page
  include Elasticsearch::Persistence::Model
  attribute :title, String
  attribute :path, String
  attribute :body, String

  def url
    base_url = Rails.configuration.jekyll_api_url
    "#{base_url}#{path}"
  end

  def to_hash
    hash = super
    hash[:url] = self.url

    hash
  end

end
