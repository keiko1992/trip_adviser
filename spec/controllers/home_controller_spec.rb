require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #index" do
    before do
      @published_articles = create_list(:published_article, 10)
      @published_future_articles = create_list(:future_article, 5)
      @hidden_articles = create_list(:hidden_article, 5)
    end

    context 'Guest' do
      it "can access" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns 10 latest publishable articles as @articles" do
        get :index
        expect(assigns(:articles)).to eq (@published_articles.reverse)
        expect(assigns(:articles).size).to eq 10
      end
    end

    context 'User' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = create(:user)
        sign_in @user
      end

      it "can access" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns 10 latest publishable articles as @articles" do
        get :index
        expect(assigns(:articles)).to eq (@published_articles.reverse)
        expect(assigns(:articles).size).to eq 10
      end
    end

    context 'Admin' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        @admin = create(:admin)
        sign_in @admin
      end

      it "can access" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns 10 latest publishable articles as @articles" do
        get :index
        expect(assigns(:articles)).to eq (@published_articles.reverse)
        expect(assigns(:articles).size).to eq 10
      end
    end
  end

end
