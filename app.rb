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
    if params['bookmark'] =~ /\A#{URI::regexp(['http', 'https'])}\z/
      Bookmark.create(params['bookmark'])
    else
      flash[:notice] = "you must submit a valid url"
    end
    redirect('/bookmarks')
  end

  run! if app_file == $0
end
