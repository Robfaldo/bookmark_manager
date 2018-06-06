require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    @bookmark_to_add = $bookmark_to_add
    erb :index
  end

  post '/bookmarks' do
    Bookmark.create(params['bookmark'])
    redirect('/bookmarks')
  end

  run! if app_file == $0
end
