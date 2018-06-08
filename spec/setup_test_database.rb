require 'pg'


def setup_test_database!
  p "Setting up the database..."

  connection = PG.connect(dbname: 'bookmark_manager_test')

  # Clear the bookmarks table
  connection.exec("TRUNCATE bookmarks;")
  # Restarts the identity column of the table
  connection.exec("TRUNCATE TABLE bookmarks RESTART IDENTITY;")
end
