class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :redirect_invalid_user, only: [:edit, :update, :destroy]
  before_action :set_popular_article_ids, only: [:index, :show]
  load_and_authorize_resource

  # GET /articles
  def index
    @articles = Article.publishable.order(published_at: :desc, id: :desc).page(params[:page]).per(12)
  end

  # GET|POST /articles/list
  def list
    @q = Article.search(params[:q])
    if admin_signed_in?
      @articles = @q.result.order(published_at: :desc, id: :desc).page(params[:page]).per(50)
    elsif user_signed_in?
      @articles = @q.result.where(user_id: current_user).order(published_at: :desc, id: :desc).page(params[:page]).per(20)
    end
  end

  # GET /articles/1
  def show
    check_permission if (@article.published_at > Time.zone.now) || !@article.published?

    @article.store_pv

    @latest_articles = Article.latest_articles(10)
    @prev_article = @article.previous_article
    @next_article = @article.next_article
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    @article["user_id"] = current_user.id

    if @article.save
      redirect_to edit_article_path(@article.slug), notice: "Article: #{@article.title} was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      redirect_to edit_article_path(@article.slug), notice: "Article: #{@article.title} was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    redirect_to list_articles_path, notice: 'Article was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.friendly.find(params[:id])
    end

    def set_popular_article_ids
      @popular_article_ids = Article.popular_article_ids(5) unless Rails.env.test?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :place, :slug, :published, :published_at, :image)
    end

    def check_permission
      return redirect_to root_path if (user_signed_in? && current_user != @article.user) || (!admin_signed_in? && !user_signed_in?)
    end

    def redirect_invalid_user
      return redirect_to root_path if user_signed_in? && current_user != @article.user
    end
end
