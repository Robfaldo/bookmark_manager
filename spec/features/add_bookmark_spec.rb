require 'web_helper'

feature 'Adding bookmarks' do
  scenario 'a user can add bookmarks' do
    visit_bookmarks_and_submit_valid_website_google
    expect(page).to have_content("Google")
  end

  scenario 'a user can click on the title and go to url' do
    visit_bookmarks_and_submit_valid_website_google
    expect(page).to have_link(nil, href: 'http://google.com')
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

  def visit_bookmarks_and_submit_valid_website_google
    visit('/bookmarks')
    fill_in('bookmark', with: 'http://google.com')
    fill_in('title', with: 'Google')
    click_button('submit')
  end

  def visit_bookmarks_and_submit_invalid_website
    visit('/bookmarks')
    fill_in('bookmark', with: 'invalid website')
    click_button('submit')
  end
end
