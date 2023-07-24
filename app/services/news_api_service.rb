# frozen_string_literal: true

class NewsApiService
  def initialize
    @client = News.new(
      ENV['NEWS_API_KEY'] || Rails.application.credentials.NEWS_api_key,
    )
  end

  def fetch_headlines
    @client.get_top_headlines(country: 'jp')
  end

  def fetch_by_category(category)
    @client.get_top_headlines(country: 'jp', category: category)
  end
end
