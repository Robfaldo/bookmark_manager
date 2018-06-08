feature 'Deleting Bookmarks' do
  scenario 'a user can delete a bookmark' do
    bookmark = Bookmark.create(url: "http://www.website.com", title: "Website")
    visit('/bookmarks')
    click_button "delete-#{bookmark.id}"
    expect(page).to have_content("Enter a bookmark")
    expect(page).not_to have_content('Website')
  end


  def visit_bookmarks_and_submit_valid_website_google
    visit('/bookmarks')
    fill_in('bookmark', with: 'http://google.com')
    fill_in('title', with: 'Google')
    click_button('submit')
  end
end
