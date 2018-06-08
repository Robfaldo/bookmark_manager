require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks in an array' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      # Add the test data
      bookmark_1 = Bookmark.create(url: 'http://makersacademy.com', title: "Makers")
      bookmark_2 = Bookmark.create(url: 'http://destroyallsoftware.com', title: "Destory all software")
      bookmark_3 = Bookmark.create(url: 'http://google.com', title: "Google")

      expected_bookmarks =[
        bookmark_1,
        bookmark_2,
        bookmark_3
      ]

      expect(Bookmark.all).to eq expected_bookmarks
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: "http://testwebsite.com")
      expect(Bookmark.all).to include bookmark
    end

    it 'adds multiple bookmark to the database' do
      bookmark_1 = Bookmark.create(url: "http://testwebsite.com")
      bookmark_2 = Bookmark.create(url: "http://google.com")
      bookmark_3 = Bookmark.create(url: "http://facebook.com")

      expected_bookmarks = [
        bookmark_1,
        bookmark_2,
        bookmark_3
      ]

      expect(Bookmark.all).to eq expected_bookmarks
    end

    it 'does not create a new bookmark if the url is not valid' do
      Bookmark.create(url: 'should not pass')
      expect(Bookmark.all).not_to include 'should not pass'
    end
  end

  describe '#==' do
    it 'two bookmarks are equal if their ids match' do
      bookmark_1 = Bookmark.new(1, 'http://google.com', title: "Google")
      bookmark_2 = Bookmark.new(1, 'http://google.com', title: "Google")

      expect(bookmark_1).to eq(bookmark_2)
    end
  end

  describe '.delete' do
    it 'deletes a bookmark from the database' do
      bookmark = Bookmark.create(url: 'http://makersacademy.com', title: "Makers")
      Bookmark.delete(bookmark.id)
      result = Bookmark.all
      expect(result.length).to eq 0
    end
  end
end
