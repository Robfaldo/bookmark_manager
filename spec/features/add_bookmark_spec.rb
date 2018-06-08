require 'web_helper'

feature 'Adding bookmarks' do
  scenario 'a user can add bookmarks' do
    visit_bookmarks_and_submit_valid_website_google
    expect(page).to have_content("Google")
  end

  scenario 'a user can click on the title and go to url' do
    visit_bookmarks_and_submit_valid_website_google
    expect(find_link('title').visible?).to eq true
  end

  scenario 'a user can add multiple bookmarks' do
    visit_bookmarks_and_submit_valid_website_google
    fill_in('bookmark', with: 'http://secondeample.com')
    fill_in('title', with: 'Second example')
    click_button('submit')
    expect(page).to have_content "Google"
    expect(page).to have_content "Second example"
  end

  scenario 'user enters invalid url' do
    visit_bookmarks_and_submit_invalid_website
    expect(page).to have_content 'you must submit a valid url'
    expect(page).not_to have_content "addbookmark"
  end
end
