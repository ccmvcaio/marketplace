require 'rails_helper'

feature 'visitor open home page' do
  scenario 'successfully'do
    visit root_path

    expect(page).to have_content('Market Place')
  end
end