feature 'Update bookmarks' do
  scenario 'it can update a bookmarks title' do
    # Setup
    bookmark = Bookmark.create(url: "http://firstwebsite.com", title: "First Title")
    # Exercise
    click_button('update-#{bookmark.id}')
    fill_in('url', with: 'http://secondwebsite.com')
    fill_in('title', with: 'Second Title')
    click_button('confirm')
    # Verify
    expect(page).to have_link(nil, href: 'http://secondwebsite.com')
    expect(page).to have_content "Second Title"
  end

  xscenario 'it can update a bookmarks url' do

  end

  xscenario 'when you only update url, it doesnt change title' do

  end

  xscenario 'when you only update title, it doesnt change url' do

  end

  def visit_bookmarks_and_submit_valid_website_google
    visit('/bookmarks')
    fill_in('bookmark', with: 'http://google.com')
    fill_in('title', with: 'Google')
    click_button('submit')
  end
end
