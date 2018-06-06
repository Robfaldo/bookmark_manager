require 'sinatra/base'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    @bookmark_to_add = $bookmark_to_add
    erb :index
  end

  post '/bookmarks' do
    $bookmark_to_add = params['bookmark']
    redirect('/bookmarks')
  end

  run! if app_file == $0
end
