require 'pg'
require 'uri'

class Bookmark

  def initialize (id, url, title)
    @id = id
    @url = url
    @title = title
  end

  def ==(other)
    @id == other.id
  end

  attr_reader :id, :url, :title

  def self.all
    connection = connect_to_correct_database
    result = connection.exec("SELECT * FROM bookmarks")
    result.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['url'], bookmark['title']) }
  end

  def self.create(options)
    return false unless self.valid_url?(options[:url])
    connection = connect_to_correct_database
    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{options[:url]}', '#{options[:title]}') RETURNING id, url, title;")
    Bookmark.new(result.first['id'], result.first['url'], result.first['title'])
  end

  def self.delete(bookmark_id)
    connection = connect_to_correct_database
    connection.exec("DELETE FROM bookmarks WHERE id = #{bookmark_id};")
  end

  private
  
  def self.valid_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

  def self.connect_to_correct_database
    if ENV['ENVIRONMENT'] == 'test'
      PG.connect(dbname: 'bookmark_manager_test')
    else
      PG.connect(dbname: 'bookmark_manager')
    end
  end

end
