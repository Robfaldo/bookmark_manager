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

end
