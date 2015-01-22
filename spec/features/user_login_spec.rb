require "rails_helper"

feature "User login" do
  let(:default_user_attributes) { { fullname: "jimbobfrank", email: "jimbobfrank@aol.com", role: "default", password: "foobar1234", password_confirmation: "foobar1234", display_name: "frankyboy" } }
  let(:admin_user_attributes) { { fullname: "frank", email: "frank@aol.com", role: "admin", password: "foobar1234", password_confirmation: "foobar1234", display_name: "franky" } }
  let(:protected_user_attributes) { { fullname: "bob", email: "bob@aol.com", role: "default", password: "pass", password_confirmation: "pass", display_name: "bob" } }
  let(:user) { User.create(default_user_attributes) }
  let(:admin_user) { User.create(admin_user_attributes) }
  let(:protected_user) { User.create(protected_user_attributes) }

  scenario "User can Welcome Page" do
    visit "/"
    expect(page).to have_content("Hello")
  end

  scenario "User can sign in with correct credentials" do
    user
    visit "/"
    within("#session") do
      fill_in "session[email]", with: "jimbobfrank@aol.com"
      fill_in "session[password]", with: "foobar1234"
    end
    click_link_or_button "Login"
    # save_and_open_page
    within("#banner") do
    expect(page).to have_content("Welcome, frankyboy")
    end
  end

  scenario "unregistered user cannot login" do
    visit "/"
    within("#session") do
      fill_in "session[email]", with: "XXjimbobfrank@aol.com"
      fill_in "session[password]", with: "XXfoobar1234"
    end
    click_link_or_button "Login"
    expect(page).to have_content("Invalid login")
  end

  scenario "registered user cannot view other user information" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                  and_return(user)
    protected_user
    visit user_path(protected_user)
    within("#flash_alert") do
      expect(page).to have_content("You are not authorized to access this page")
    end
  end

  scenario "an admin can view other users information" do
    admin_user
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                  and_return(admin_user)
    visit user_path(user)
    within("#banner") do
      expect(page).to have_content("Welcome, frankyboy")
    end
  end
end
