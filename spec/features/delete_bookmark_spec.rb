feature 'Deleting Bookmarks' do
  scenario 'a user can delete a bookmark' do
    bookmark = Bookmark.create(url: "http://www.website.com", title: "Website")
    visit('/bookmarks')
    click_button "delete-#{bookmark.id}"
    expect(page).not_to have_content('Website')
  end
end
