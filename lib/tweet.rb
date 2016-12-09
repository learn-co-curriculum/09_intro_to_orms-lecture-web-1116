class Tweet
  attr_accessor :message, :username, :id

  def self.all
    # find all the rows in the database
    sql = <<-SQL
    SELECT *
    FROM tweets;
    SQL
    results = DB[:conn].execute(sql)
    results.map do |tweet_result|
      Tweet.new(tweet_result)
    end
  end

  # def self.first
  #   self.all.first
  # end

  def initialize(options={})
    @message = options['message']
    @username = options['username']
    @id = options['id']
  end

  def save
    self.id ? update : create
    self
  end

  def create
    sql = <<-SQL
      INSERT INTO tweets (username, message)
      VALUES (? , ?)
    SQL
    DB[:conn].execute(sql, self.username, self.message)

    id_sql = <<-SQL
    SELECT id FROM tweets
    ORDER BY id DESC
    LIMIT 1
    SQL

    id_result = DB[:conn].execute(id_sql).first
    @id = id_result["id"]
  end

  def update
    sql = <<-SQL
    UPDATE tweets 
    SET username = ?, message = ?
    WHERE id = ?
    SQL
    DB[:conn].execute(sql, self.username, self.message, self.id)
  end

  def self.find(id)
    sql = <<-SQL
        SELECT * 
        FROM tweets
        WHERE id = ?
        SQL
    found_tweet = DB[:conn].execute(sql, id).first
    
    if found_tweet.nil?
      raise TweetError, "No tweet found - please try again"
    else
      Tweet.new(found_tweet)
    end

  end


  def ==(obj)
    self.id == obj.id
  end

  def self.where(query_hash)
    key = query_hash.keys.first
    value = query_hash[key]
    sql = <<-SQL
        SELECT * 
        FROM tweets
        WHERE #{key} = ?
        SQL
    DB[:conn].execute(sql, value).map { |result| Tweet.new(result) }

    end

  class TweetError < StandardError
    def initalize(message = "Something broke")
      puts message
      super
    end
end
  

end
