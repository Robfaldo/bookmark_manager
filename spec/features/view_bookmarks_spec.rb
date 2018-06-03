feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    visit('/bookmarks')
    expect(page).to have_content "http://makersacademy.com"
    expect(page).to have_content "http://destroyallsoftware.com"
    expect(page).to have_content "http://google.com"
  end
end

# I could say it has div#view_saved_bookmarks
# I could say it has particular content inside of it
    # Could be the title 'Saved Bookmarks'
    # Could be an example of an actual bookmark
