feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    # Add the test data
    connection.exec("INSERT INTO bookmarks (url, title) VALUES('http://makersacademy.com', 'Makers');")
    connection.exec("INSERT INTO bookmarks (url, title) VALUES('http://destroyallsoftware.com', 'Destory');")
    connection.exec("INSERT INTO bookmarks (url, title) VALUES('http://google.com', 'Google');")

    visit('/bookmarks')
    expect(page).to have_content "Makers"
    expect(page).to have_content "Destory"
    expect(page).to have_content "Google"
  end
end
