require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  let!(:product) { FactoryBot.create :product }
  let!(:user) {FactoryBot.create :user}
  let!(:list_reviews) {FactoryBot.create_list :review, 2, user_id: user.id, product_id: product.id}

  describe "before action" do
    it {is_expected.to use_before_action(:load_product)}
  end

  describe "GET ProductsController#show" do
    before do
      get :show, params: {id: product.id}
    end

    it "should render show page" do
      expect(response).to render_template(:show)
    end

    it "should be success" do
      expect(response).to have_http_status(:ok)
    end

    it "should return reviews" do
      expect(assigns(:reviews)).to match_array(list_reviews)
    end
  end
end
