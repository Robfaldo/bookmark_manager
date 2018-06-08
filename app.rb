require 'sinatra/base'
require 'sinatra/flash'
require 'uri'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base

  enable :sessions
  register Sinatra::Flash
  use Rack::MethodOverride

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :index
  end

  post '/bookmarks' do
    valid_url = Bookmark.create(url: params['bookmark'], title: params['title'])
    flash[:notice] = "you must submit a valid url" unless valid_url
    redirect('/bookmarks')
  end

  delete '/bookmarks/:id/delete' do
    Bookmark.delete(params[:id])
    redirect('/bookmarks')
  end

  run! if app_file == $0
end
