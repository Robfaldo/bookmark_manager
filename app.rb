require 'sinatra/base'
require 'sinatra/flash'
require 'uri'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    @bookmark_to_add = $bookmark_to_add
    erb :index
  end

  post '/bookmarks' do
    # Bookmark.create(params['bookmark'])
    # we need the flash notice
    valid_url = Bookmark.create(params['bookmark'])

    flash[:notice] = "you must submit a valid url" unless valid_url

    redirect('/bookmarks')
  end

  run! if app_file == $0
end
