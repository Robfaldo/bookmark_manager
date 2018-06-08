feature 'Deleting Bookmarks' do
  scenario 'a user can delete a bookmark' do
    visit_bookmarks_and_submit_valid_website_google
    click_button "delete-1"
    expect(page).not_to have_content('Website')
  end
end
