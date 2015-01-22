require "rails_helper"

feature "User login" do
  background do
    @user = User.create(
      fullname: "jimbobfrank",
      email: "jimbobfrank@aol.com",
      role:  0,
      password: "foobar1234",
      password_confirmation: "foobar1234",
      display_name: "frankyboy"
    )
  end

  scenario "User can sign in with correct credentials" do
    visit "/"
    within("#session") do
      fill_in "session[email]", with: "jimbobfrank@aol.com"
      fill_in "session[password]", with: "foobar1234"
    end
    click_link_or_button "Login"
    within("#user_nav") do
      expect(page).to have_content("Welcome, jimbobfrank")
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
end
