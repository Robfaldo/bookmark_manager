require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks in an array' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      # Add the test data
      connection.exec("INSERT INTO bookmarks (url) VALUES('http://makersacademy.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('http://destroyallsoftware.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('http://google.com');")

      expected_bookmarks =[
        'http://makersacademy.com',
        'http://destroyallsoftware.com',
        'http://google.com'
      ]

      expect(Bookmark.all).to eq expected_bookmarks

    end
  end

  describe '.create' do
    it 'adds a bookmark to the database' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      Bookmark.create("http://testwebsite.com")

      database_data = connection.exec("SELECT * FROM bookmarks")

      results = database_data.map { |bookmark| bookmark['url'] }

      expect(results).to eq ['http://testwebsite.com']
    end

    it 'adds multiple bookmark to the database' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      Bookmark.create("http://testwebsite.com")
      Bookmark.create("http://google.com")
      Bookmark.create("http://facebook.com")

      database_data = connection.exec("SELECT * FROM bookmarks")

      results = database_data.map { |bookmark| bookmark['url'] }

      expected_bookmarks = [
        "http://testwebsite.com",
        "http://google.com",
        "http://facebook.com"
      ]

      expect(results).to eq expected_bookmarks
    end
  end
end
