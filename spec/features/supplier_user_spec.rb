require "rails_helper"

feature "supplier visits the site" do
  scenario "supplier can view listing page" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(@supplier_user)
    visit root_path
    within("#items")
  end
end
