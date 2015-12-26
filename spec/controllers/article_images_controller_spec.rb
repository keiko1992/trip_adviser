require 'rails_helper'

RSpec.describe ArticleImagesController, type: :controller do
  describe "POST #create" do
    before do
      @user = create(:user)
      @other_user = create(:user)
      @article = create(:article, user_id: @user.id)
      @other_article = create(:article, user_id: @other_user.id)
      @article_image = attributes_for(:article_image, article_id: nil)

      request.env["HTTP_REFERER"] = edit_article_url(@article.slug)
    end

    context 'Guest' do
      it "can't access" do
        post :create, article_image: @article_image
        expect(response).to redirect_to root_path
      end
    end

    context 'User' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @user
      end

      context "owns the requested article" do
        context "with valid params" do
          it "creates a new ArticleImage" do
            expect {post :create, article_image: @article_image}.to change(ArticleImage, :count).by(1)
          end

          it "assigns the requested article as @article" do
            post :create, article_image: @article_image
            expect(assigns(:article)).to eq(@article)
          end

          it "sets an article_id to a newly created article_image" do
            post :create, article_image: @article_image
            expect(ArticleImage.last.article_id).to eq @article.id
          end

          it "returns 200" do
            post :create, article_image: @article_image
            expect(response.status).to eq 200
          end
        end

        context "with invalid params" do
          before do
            allow_any_instance_of(ArticleImage).to receive(:save).and_return(false)
          end

          it "doesn't create a new ArticleImage" do
            expect {post :create, article_image: @article_image}.to change(ArticleImage, :count).by(0)
          end

          it "returns 500" do
            post :create, article_image: @article_image
            expect(response.status).to eq 500
          end
        end
      end

      context "doesn't own the requested article" do
        before do
          request.env["HTTP_REFERER"] = edit_article_url(@other_article.slug)
        end

        it "can't access" do
          post :create, article_image: @article_image
          expect(response).to redirect_to root_path
        end
      end
    end

    context 'Admin' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        @admin = create(:admin)
        sign_in @admin
      end

      it "can't access" do
        post :create, article_image: @article_image
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @user = create(:user)
      @other_user = create(:user)
      @article = create(:article, user_id: @user.id)
      @other_article = create(:article, user_id: @other_user.id)
      @article_image = create(:article_image, article_id: @article.id)
      @file_url = "https://bucket.s3.amazonaws.com/article/embedded_images/#{@article_image.id}/filename/size?slug"

      request.env["HTTP_REFERER"] = edit_article_url(@article.slug)
    end

    context 'Guest' do
      it "can't access" do
        delete :destroy, file: @file_url
        expect(response).to redirect_to root_path
      end
    end

    context 'User' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @user
      end

      context "owns the requested article" do
        it "destroys the requested article_image" do
          expect {delete :destroy, file: @file_url}.to change(ArticleImage, :count).by(-1)
        end

        it "returns 200" do
          delete :destroy, file: @file_url
          expect(response.status).to eq 200
        end
      end

      context "doesn't own the requested article" do
        before do
          request.env["HTTP_REFERER"] = edit_article_url(@other_article.slug)
        end

        it "can't access" do
          delete :destroy, file: @file_url
          expect(response).to redirect_to root_path
        end
      end
    end

    context 'Admin' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        @admin = create(:admin)
        sign_in @admin
      end

      it "can't access" do
        delete :destroy, file: @file_url
        expect(response).to redirect_to root_path
      end
    end
  end

end
