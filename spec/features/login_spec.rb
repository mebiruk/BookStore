require "rails_helper"

RSpec.feature "Login", type: :feature do
  let!(:user) {FactoryBot.create :user}
  let!(:admin) { FactoryBot.create :user, role: 1 }
  before do
    visit login_path
  end

  feature "Login success" do
    scenario "role: user" do
      fill_in "session[email]", with: user.email
      fill_in "session[password]", with: user.password
      click_button "commit"
      expect(page).to have_text I18n.t "layouts.top_product.seeall"
    end

    scenario "role: admin" do
      fill_in "session[email]", with: admin.email
      fill_in "session[password]", with: admin.password
      click_button "commit"
      expect(page).to have_text I18n.t "layouts.top_product.seeall"
    end
  end

  feature "Invalid input" do
    scenario "miss email" do
      fill_in "session[password]", with: user.password
      click_button "commit"
      expect(page).to have_text I18n.t "invalid"
    end

    scenario "miss password" do
      fill_in "session[email]", with: user.email
      click_button "commit"
      expect(page).to have_text I18n.t "invalid"
    end

    scenario "miss both field" do
      click_button "commit"
      expect(page).to have_text I18n.t "invalid"
    end
  end

  feature "Login failed" do
    scenario "wrong email & password" do
      fill_in "session[email]", with: "acv@gmail"
      fill_in "session[password]", with: "123123"
      click_button "commit"
      expect(page).to have_text I18n.t "invalid"
    end
  end
end

