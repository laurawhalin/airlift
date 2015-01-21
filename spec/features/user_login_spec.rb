require "rails_helper"

feature "User login" do
  background do
    User.create(:email => "jimbobfrank@aol.com", :password => 'foobar1234' )
  end

  scenario "User can sign in with correct credentials" do
    visit "/login"
      within("#session") do
      fill_in "session[email]", :with => "jimbobfrank@aol.com"
      fill_in "session[password]", :with => "foobar1234"
      fill_in "session[password_confirmation]", :with => "foobar1234"
    end
    click_button "Login"
    expect(page).to have_content("You have successfully logged in")
  end
end
