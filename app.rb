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
    valid_url = Bookmark.create(url: params['bookmark'], title: params['title'])
    flash[:notice] = "you must submit a valid url" unless valid_url
    if !params[:id].nil?
      Bookmark.delete(params[:id])
    end
    redirect('/bookmarks')
  end

  run! if app_file == $0
end
