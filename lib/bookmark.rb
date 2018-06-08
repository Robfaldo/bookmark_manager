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
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec("SELECT * FROM bookmarks")
    result.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['url'], bookmark['title']) }
  end

  def self.create(options)
    return false unless self.valid_url?(options[:url])

    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    # we need to add title into the create database so that we get back an object with title aswell as id and url
    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{options[:url]}', '#{options[:title]}') RETURNING id, url, title;")

    Bookmark.new(result.first['id'], result.first['url'], result.first['title'])
  end

  # def self.delete(bookmark_id)
  #
  #   #
  #
  # end

  private
  def self.valid_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

end
