class HomeController < ApplicationController
  def index
    @articles = Article.publishable.order(published_at: :desc, id: :desc).limit(10)
    @popular_article_ids = Article.popular_article_ids(5) unless Rails.env.test?
  end
end
