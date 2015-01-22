require "rails_helper"

feature "User can register" do
  scenario "User can register with valid credentials" do
  visit "/"
  click_link_or_button "Register"
  visit "/register"
  fill_in "user[fullname]", with: "Jim Bob"
  fill_in "user[email]", with: "jimbob@gmail.com"
  fill_in "user[password]", with: "foobar12"
  fill_in "user[password_confirmation]", with: "foobar12"
  fill_in "user[display_name]", with: "frankyboi"
  click_link_or_button "Signup"
  within("#success") do
    expect(page).to have_content("You have successfully registered.")
  end
  #expect current page to be the root?
  end
end

#   scenario "User can sign in with correct credentials" do
#     visit "/"
#     within("#session") do
#       fill_in "session[email]", with: "jimbobfrank@aol.com"
#       fill_in "session[password]", with: "foobar1234"
#     end
#     click_link_or_button "Login"
#     # save_and_open_page
#     within("#banner") do
#       expect(page).to have_content("Welcome, frankyboy")
#     end
#   end
#
#   scenario "unregistered user cannot login" do
#     visit "/"
#     within("#session") do
#       fill_in "session[email]", with: "XXjimbobfrank@aol.com"
#       fill_in "session[password]", with: "XXfoobar1234"
#     end
#     click_link_or_button "Login"
#     # save_and_open_page
#     # within("#errors") do
#     expect(page).to have_content("Invalid login")
#   end
# end
