require "rails_helper"

RSpec.describe Admin::CategoriesController, type: :controller do
  context "no login" do
    describe "GET #new" do
      before do
        get :new
      end

      it "should redirect to login page" do
        expect(response).to redirect_to(login_path)
      end

      it "should found" do
        expect(response).to have_http_status(302)
      end
    end

    describe "POST #create" do
      before do
        post :create
      end

      it "should redirect to login page" do
        expect(response).to redirect_to(login_path)
      end

      it "should found" do
        expect(response).to have_http_status(302)
      end
    end
  end

  context "logged in" do
    before do
      user = FactoryBot.create :user, role: 1
      log_in user
    end
    describe "GET #new" do
      before do
        get :new
      end

      it "should create new category" do
        expect(assigns(:category)).to be_a_new(Category)
      end

      it "should be success" do
        expect(response).to have_http_status(:ok)
      end

      it "should render new page" do
        expect(response).to render_template(:new)
      end
    end

    describe "POST #create" do
      context "create successful" do
        before do
          post :create, params: {category: FactoryBot.attributes_for(:category)}
        end

        it "should create new category" do
          expect{post :create, params:{category: FactoryBot.attributes_for(:category)}}
            .to change(Category, :count).by(1)
        end

        it "should redirect to root url" do
          expect(response).to redirect_to(root_url)
        end

        it "should flash success" do
          expect(flash[:success]).to match(I18n.t("category_created"))
        end
      end

      context "create failed" do
        before do
          post :create, params: {category: {name: nil}}
        end

        it "should create fail with no name" do
          expect{post :create, params: {category: {name: nil}}}.to change(Category, :count).by(0)
        end

        it "should flash fails" do
          expect(flash[:danger]).to match(I18n.t("create_failse"))
        end

        it "should render new page" do
          expect(response).to render_template(:new)
        end
      end
    end
  end
end

