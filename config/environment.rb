require 'bundler'
Bundler.require

DB = {
  conn: SQLite3::Database.new('db/twitter.db')
}


DB[:conn].results_as_hash = true

# result = [{id: 1, username: 'coffeedad', message: 'good coffee', 0 => 1, 1 => 'coffeedad', 2 => 'good coffee'}]
#
# first_row = result.first
#
# first_row[0]
# # [{id: 1, name: "Pikachu", type: "electricity", }]
require_relative '../lib/tweet.rb'
require_relative '../lib/tweets_app.rb'

# DB[:conn].execute("CREATE TABLE tweets ")


# module SQLite3
#
#   class Database
#
#     def execute
#       if self.results_as_hash
#         # return a hash
#       else
#         # return an array
#       end
#
#     end
#   end
#
# end
