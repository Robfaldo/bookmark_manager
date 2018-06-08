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
