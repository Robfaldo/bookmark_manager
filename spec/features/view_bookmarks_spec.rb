feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    # Add the test data
    connection.exec("INSERT INTO bookmarks (url) VALUES('http://makersacademy.com');")
    connection.exec("INSERT INTO bookmarks (url) VALUES('http://destroyallsoftware.com');")
    connection.exec("INSERT INTO bookmarks (url) VALUES('http://google.com');")

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
