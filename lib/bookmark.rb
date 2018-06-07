require 'pg'
require 'uri'

class Bookmark

  def initialize (id, url)
    @id = id
    @url = url
  end

  def ==(other)
    @id == other.id
  end

  attr_reader :id, :url

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec("SELECT * FROM bookmarks")
    result.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['url']) }
  end

  def self.create(options)
    return false unless self.valid_url?(options[:url])
  
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec("INSERT INTO bookmarks (url) VALUES('#{options[:url]}') RETURNING id, url")
    Bookmark.new(result.first['id'], result.first['url'])
  end

  private
  def self.valid_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

end
