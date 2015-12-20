class HomeController < ApplicationController
  def index
    @articles = Article.publishable.order(published_at: :desc, id: :desc).limit(10)
  end
end
