# As a user,
# so I can keep track of and share the websites I want to revisit,
# I need to be able to add a bookmark

feature 'Adding bookmarks' do
  scenario 'a user can add bookmarks' do
    # Setup
    visit('/bookmarks')
    # Exercise
    fill_in('bookmark', with: 'http://addbookmark.com')
    click_button('submit')
    # Verify
    expect(page).to have_content "http://addbookmark.com"
  end
  scenario 'a user can add multiple bookmarks' do
    # Setup
    visit('/bookmarks')
    # Exercise
    fill_in('bookmark', with: 'http://addbookmark.com')
    click_button('submit')
    fill_in('bookmark', with: 'http://secondeample.com')
    click_button('submit')
    # Verify
    expect(page).to have_content "http://addbookmark.com"
    expect(page).to have_content "http://secondeample.com"
  end

  scenario 'user enters invalid url' do
    visit('/bookmarks')
    # Exercise
    fill_in('bookmark', with: 'addbookmark')
    click_button('submit')
    expect(page).to have_content 'you must submit a valid url'
    expect(page).not_to have_content "addbookmark"
  end

end
