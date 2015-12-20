require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "GET #index" do
    before do
      @published_articles = create_list(:published_article, 5)
      @published_future_articles = create_list(:future_article, 5)
      @hidden_articles = create_list(:hidden_article, 5)
    end

    context 'Guest' do
      it "can access" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns all publishable articles as @articles" do
        get :index
        expect(assigns(:articles)).to eq(@published_articles.reverse)
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

      it "assigns all publishable articles as @articles" do
        get :index
        expect(assigns(:articles)).to eq(@published_articles.reverse)
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

      it "assigns all publishable articles as @articles" do
        get :index
        expect(assigns(:articles)).to eq(@published_articles.reverse)
      end
    end
  end

  describe "GET #list" do
    before do
      @user = create(:user)
      @other_user = create(:user)

      @articles = create_list(:published_article, 5, user_id: @user.id)
      @other_articles = create_list(:published_article, 5, user_id: @other_user.id)
    end

    context 'Guest' do
      it "can't access" do
        get :list
        expect(response).to redirect_to root_path
      end
    end

    context 'User' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @user
      end

      it "can access" do
        get :list
        expect(response).to have_http_status(:success)
      end

      it "assigns all of own articles as @articles" do
        get :list
        expect(assigns(:articles)).to eq(@articles.reverse)
      end
    end

    context 'Admin' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        @admin = create(:admin)
        sign_in @admin
      end

      it "can access" do
        get :list
        expect(response).to have_http_status(:success)
      end

      it "assigns all articles as @articles" do
        get :list
        expect(assigns(:articles)).to eq (@other_articles.reverse + @articles.reverse)
      end
    end
  end

  describe "GET #show" do
    before do
      @user = create(:user)
      @other_user = create(:user)

      @previous_published_article = create(:published_article, user_id: @user.id, published_at: Time.zone.now - 3.day)
      @published_article = create(:published_article, user_id: @user.id, published_at: Time.zone.now - 2.day)
      @next_published_article = create(:published_article, user_id: @user.id, published_at: Time.zone.now - 1.day)

      @published_future_article = create(:future_article, user_id: @user.id)
      @hidden_article = create(:hidden_article, user_id: @user.id)

      @published_articles = create_list(:published_article, 10)
      @future_articles = create_list(:future_article, 10)
      @hidden_articles = create_list(:hidden_article, 10)
    end

    context 'Guest' do
      it "can access to published article" do
        get :show, id: @published_article.slug
        expect(response).to have_http_status(:success)
        expect(assigns(:article)).to eq(@published_article)
      end

      it "can NOT access to future article" do
        get :show, id: @published_future_article.slug
        expect(response).to redirect_to root_path
      end

      it "can NOT access to hidden article" do
        get :show, id: @hidden_article.slug
        expect(response).to redirect_to root_path
      end

      it "assigns 10 latest articles as @latest_articles" do
        get :show, id: @published_article.slug
        expect(assigns(:latest_articles)).to eq(@published_articles.reverse)
      end

      it "assigns previous article as @prev_article" do
        get :show, id: @published_article.slug
        expect(assigns(:prev_article)).to eq(@previous_published_article)
      end

      it "assigns next article as @next_article" do
        get :show, id: @published_article.slug
        expect(assigns(:next_article)).to eq(@next_published_article)
      end
    end

    context 'User' do
      context 'is an author of the requested article' do
        before do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          sign_in @user
        end

        it "can access to published article" do
          get :show, id: @published_article.slug
          expect(response).to have_http_status(:success)
          expect(assigns(:article)).to eq(@published_article)
        end

        it "can access to future article" do
          get :show, id: @published_future_article.slug
          expect(response).to have_http_status(:success)
          expect(assigns(:article)).to eq(@published_future_article)
        end

        it "can access to hidden article" do
          get :show, id: @hidden_article.slug
          expect(response).to have_http_status(:success)
          expect(assigns(:article)).to eq(@hidden_article)
        end
      end

      context 'is NOT an author of the requested article' do
        before do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          sign_in @other_user
        end

        it "can access to published article" do
          get :show, id: @published_article.slug
          expect(response).to have_http_status(:success)
          expect(assigns(:article)).to eq(@published_article)
        end

        it "can NOT access to future article" do
          get :show, id: @published_future_article.slug
          expect(response).to redirect_to root_path
        end

        it "can NOT access to hidden article" do
          get :show, id: @hidden_article.slug
          expect(response).to redirect_to root_path
        end
      end

      context 'is whoever' do
        before do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          sign_in @user
        end

        it "assigns 10 latest articles as @latest_articles" do
          get :show, id: @published_article.slug
          expect(assigns(:latest_articles)).to eq(@published_articles.reverse)
        end

        it "assigns previous article as @prev_article" do
          get :show, id: @published_article.slug
          expect(assigns(:prev_article)).to eq(@previous_published_article)
        end

        it "assigns next article as @next_article" do
          get :show, id: @published_article.slug
          expect(assigns(:next_article)).to eq(@next_published_article)
        end
      end
    end

    context 'Admin' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        @admin = create(:admin)
        sign_in @admin
      end

      it "can access to published article" do
        get :show, id: @published_article.slug
        expect(response).to have_http_status(:success)
        expect(assigns(:article)).to eq(@published_article)
      end

      it "can access to future article" do
        get :show, id: @published_future_article.slug
        expect(response).to have_http_status(:success)
        expect(assigns(:article)).to eq(@published_future_article)
      end

      it "can access to hidden article" do
        get :show, id: @hidden_article.slug
        expect(response).to have_http_status(:success)
        expect(assigns(:article)).to eq(@hidden_article)
      end

      it "assigns 10 latest articles as @latest_articles" do
        get :show, id: @published_article.slug
        expect(assigns(:latest_articles)).to eq(@published_articles.reverse)
      end

      it "assigns previous article as @prev_article" do
        get :show, id: @published_article.slug
        expect(assigns(:prev_article)).to eq(@previous_published_article)
      end

      it "assigns next article as @next_article" do
        get :show, id: @published_article.slug
        expect(assigns(:next_article)).to eq(@next_published_article)
      end
    end
  end

  describe "GET #new" do
    context 'Guest' do
      it "can't access" do
        get :new
        expect(response).to redirect_to root_path
      end
    end

    context 'User' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = create(:user)
        sign_in @user
      end

      it "can access" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "assigns a new category as @category" do
        get :new
        expect(assigns(:article)).to be_a_new(Article)
      end
    end

    context 'Admin' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        @admin = create(:admin)
        sign_in @admin
      end

      it "can't access" do
        get :new
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "GET #edit" do
    before do
      @user = create(:user)
      @other_user = create(:user)

      @article = create(:article, user_id: @user.id)
      @other_article = create(:article, user_id: @other_user.id)
    end

    context 'Guest' do
      it "can't access" do
        get :edit, id: @article.slug
        expect(response).to redirect_to root_path
      end
    end

    context 'User' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @user
      end

      it "can assign the own article as @article" do
        get :edit, id: @article.slug
        expect(assigns(:article)).to eq(@article)
      end

      it "can't assign the other article" do
        get :edit, id: @other_article.slug
        expect(response).to redirect_to root_path
      end
    end

    context 'Admin' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        @admin = create(:admin)
        sign_in @admin
      end

      it "can't access" do
        get :edit, id: @article.slug
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "POST #create" do
    before do
      @article = attributes_for(:article)
    end

    context 'Guest' do
      it "can't access" do
        post :create, article: @article
        expect(response).to redirect_to root_path
      end
    end

    context 'User' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = create(:user)
        sign_in @user
      end

      context "with valid params" do
        it "creates a new Article" do
          expect {post :create, article: @article}.to change(Article, :count).by(1)
        end

        it "assigns a newly created article as @article" do
          post :create, article: @article
          expect(assigns(:article)).to be_a(Article)
          expect(assigns(:article)).to be_persisted
        end

        it "sets an user_id to a newly created article" do
          post :create, article: @article
          expect(Article.last.user_id).to eq @user.id
        end

        it "redirects to the articles#edit" do
          post :create, article: @article
          expect(response).to redirect_to edit_article_path(Article.last.slug)
        end
      end

      context "with invalid params" do
        before do
          allow_any_instance_of(Article).to receive(:save).and_return(false)
        end

        it "assigns a newly created but unsaved user as @article" do
          post :create, article: @article
          expect(assigns(:article)).to be_a_new(Article)
        end

        it "re-renders the 'new' template" do
          post :create, article: @article
          expect(response).to render_template("new")
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
        post :create, article: @article
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "PUT #update" do
    before do
      @user = create(:user)
      @other_user = create(:user)

      @article = create(:article, user_id: @user.id)
      @other_article = create(:article, user_id: @other_user.id)

      @update = attributes_for(:article)
    end

    context 'Guest' do
      it "can't access" do
        put :update, id: @article.slug, article: @update
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
          it "updates the requested article" do
            put :update, id: @article.slug, article: @update
            @article.reload
            expect(@article.title).to eq(@update[:title])
          end

          it "assigns the requested article as @article" do
            put :update, id: @article.slug, article: @update
            expect(assigns(:article)).to eq(@article)
          end

          it "redirects to the articles#edit" do
            put :update, id: @article.slug, article: @update
            @article.reload
            expect(response).to redirect_to edit_article_path(@article.slug)
          end
        end

        context "with invalid params" do
          before do
            allow_any_instance_of(Article).to receive(:save).and_return(false)
          end

          it "assigns the article as @article" do
            put :update, id: @article.slug, article: @update
            expect(assigns(:article)).to eq(@article)
          end

          it "re-renders the 'edit' template" do
            put :update, id: @article.slug, article: @update
            expect(response).to render_template("edit")
          end
        end
      end

      context "doesn't own the requested article" do
        it "can't access" do
          put :update, id: @other_article.slug, article: @update
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
        put :update, id: @article.slug, article: @update
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
    end

    context 'Guest' do
      it "can't access" do
        delete :destroy, id: @article.slug
        expect(response).to redirect_to root_path
      end
    end

    context 'User' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @user
      end

      context "owns the requested article" do
        it "can destroy the requested article" do
          expect {delete :destroy, id: @article.slug}.to change(Article, :count).by(-1)
        end

        it "redirects to the articles#list" do
          delete :destroy, id: @article.slug
          expect(response).to redirect_to list_articles_path
        end
      end

      context "doesn't own the requested article" do
        it "can't access" do
          delete :destroy, id: @other_article.slug
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

      it "destroys the requested article" do
        expect {delete :destroy, id: @article.slug}.to change(Article, :count).by(-1)
      end

      it "redirects to the articles#list" do
        delete :destroy, id: @article.slug
        expect(response).to redirect_to list_articles_path
      end
    end
  end

end
