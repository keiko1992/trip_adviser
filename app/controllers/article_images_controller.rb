class ArticleImagesController < ApplicationController
  before_action :set_article_image, only: :destroy

  # POST /article_images
  def create
    @article_image = ArticleImage.new(article_image_params)

    respond_to do |format|
      if @article_image.save
        format.html { redirect_to @article_image, notice: 'Article image was successfully created.' }
        format.json { render :show, status: :created, location: @article_image }
      else
        format.html { render :new }
        format.json { render json: @article_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /article_images/1
  def destroy
    @article_image.destroy
    respond_to do |format|
      format.html { redirect_to article_images_url, notice: 'Article image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article_image
      @article_image = ArticleImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_image_params
      params.require(:article_image).permit(:article_id)
    end
end
