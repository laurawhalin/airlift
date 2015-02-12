require "rails_helper"

feature "User can register" do
  scenario "User can register with valid credentials" do
    visit root_path
    first(:button, "Register").click
    within(".reg-modal") do
      fill_in "user[fullname]", with: "Jim Bob"
      fill_in "user[email]", with: "jimbob@gmail.com"
      fill_in "user[password]", with: "foobar12"
      fill_in "user[password_confirmation]", with: "foobar12"
      fill_in "user[display_name]", with: "frankyboi"
      click_link_or_button "Sign Up"
    end
    within("#user_nav") do
      expect(page).to have_content("Welcome, Jim Bob")
    end
  end

  scenario "User can register from login modal" do
    visit root_path
    first(:button, "Log In").click
    within(".login-modal") do
      click_link_or_button "Not Registered?"
    end

    within(".reg-form") do
      expect(page).to have_content("Full Name")
      expect(page).to have_content("Email")
    end
  end
end
