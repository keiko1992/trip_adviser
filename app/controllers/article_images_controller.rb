class ArticleImagesController < ApplicationController
  before_action :set_article_image, only: :destroy
  before_action :set_article
  before_action :redirect_invalid_user
  load_and_authorize_resource

  # POST /article_images
  def create
    @article_image = ArticleImage.new(article_image_params)
    @article_image['article_id'] = @article.id

    if @article_image.save
      url_response = {files: [{url: @article_image.image.url(:large)}]}
      render json: url_response, status: 200
    else
      render nothing: true, status: 500
    end
  end

  # DELETE /article_images/1
  def destroy
    if @article_image.destroy
      render nothing: true, status: 200
    else
      render nothing: true, status: 500
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article_image
      article_image_slug = params[:file].split("/")[5]
      @article_image = ArticleImage.find(article_image_slug)
    end

    def set_article
      article_slug = request.referer.split("/")[4]
      @article = Article.friendly.find(article_slug)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_image_params
      params.require(:article_image).permit(:image)
    end

    def redirect_invalid_user
      return redirect_to root_path if user_signed_in? && current_user != @article.user
    end
end
