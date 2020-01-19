require "rails_helper"

RSpec.describe Product, type: :model do

  let(:category) { FactoryBot.create :category }
  subject { FactoryBot.create :product, category_id: category.id }

  describe "Create" do
    it {is_expected.to be_valid}
  end

  describe "Database" do
    it {is_expected.to have_db_column(:title).of_type :string}
    it { is_expected.to have_db_column(:publisher_name).of_type :string }
    it { is_expected.to have_db_column(:author_name).of_type :string }
    it {is_expected.to have_db_column(:price).of_type :float}
    it {is_expected.to have_db_column(:num_exist).of_type :integer}
    it { is_expected.to have_db_column(:picture).of_type :string }
    it {is_expected.to have_db_column(:description).of_type :text}
  end

  describe "Association" do
    it {is_expected.to belong_to :category}
  end

  describe "title" do
    context "valid" do
      it { is_expected.to validate_presence_of(:title)
        .with_message(I18n.t("activerecord.errors.models.product.attributes.title.blank"))}
      it {is_expected.to validate_length_of(:title)
        .is_at_most(Settings.factories.products.title_max_length)
        .with_message(I18n.t("activerecord.errors.models.product.attributes.title.too_long"))}
    end

    context "invalid" do
      before {subject.title = "a" * Settings.factories.products.invalid}
      it {is_expected.not_to be_valid}
    end
  end

describe "publisher name" do
  context "valid" do
    it {is_expected.to validate_presence_of(:publisher_name)
      .with_message(I18n.t("activerecord.errors.models.product.attributes.publisher_name.blank"))}
    it {is_expected.to validate_length_of(:publisher_name)
      .is_at_most(Settings.factories.products.publisher_max_length)
      .with_message(I18n.t("activerecord.errors.models.product.attributes.publisher_name.too_long"))
    }
  end

  context "invalid" do
    before {subject.publisher_name = "a" * Settings.factories.products.invalid}
    it {is_expected.not_to be_valid }
  end
end

describe "author name" do
  context "valid" do
    it {is_expected.to validate_presence_of(:author_name)
      .with_message(I18n.t("activerecord.errors.models.product.attributes.author_name.blank"))}
    it {is_expected.to validate_length_of(:author_name)
      .is_at_most(Settings.factories.products.author_max_length)
      .with_message(I18n.t("activerecord.errors.models.product.attributes.author_name.too_long"))}
  end

  context "invalid" do
    before { subject.author_name = "a" * Settings.factories.products.invalid }
    it { is_expected.not_to be_valid }
  end
end

  describe "validations rest" do
    it { is_expected.to validate_presence_of(:price)
      .with_message(I18n.t("activerecord.errors.models.product.attributes.price.blank"))}
    it { is_expected.to validate_presence_of(:picture)
      .with_message(I18n.t("activerecord.errors.models.product.attributes.picture.blank"))}
    it { is_expected.to validate_presence_of(:num_exist)
      .with_message(I18n.t("activerecord.errors.models.product.attributes.num_exist.blank"))}
    it { is_expected.to validate_presence_of(:description)
      .with_message(I18n.t("activerecord.errors.models.product.attributes.description.blank"))}
  end

  describe "Scopes" do
    before :each do
      @category1 = FactoryBot.create :category
      @a,@b,@c = ["book1", "book2", "book3"].map{|title| FactoryBot.create :product,
        title: title, category_id: @category1.id}
    end

    it "product by category" do
      expect(Product.by_category(1)).to eq [@a,@b,@c]
    end

    it "search by title" do
      expect(Product.search("book3")).to eq [@c]
    end
  end
end

