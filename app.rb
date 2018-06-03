require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  get '/' do
    'Hello, worldy!'
  end

  get '/bookmarks' do
    @bookmarks = [
      "http://makersacademy.com",
      "http://destroyallsoftware.com",
      "http://google.com",
    ]
    erb :index
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
