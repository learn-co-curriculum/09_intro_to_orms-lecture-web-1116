class Tweet
  attr_accessor :message, :username, :id

  def self.all
    # find all the rows in the database
    sql = <<-SQL
    SELECT *
    FROM tweets;
    SQL
    results = DB[:conn].execute(sql)
    # create an instance for each row
    results.map do |tweet_result|
      # tweet_result ==> {"id"=>1, "username"=>"coffeedad", "message"=>"good coffee"}
      # Tweet.new({"id" => tweet_result["id"], "username" => tweet_result["username"], "message" => tweet_result["message"]})
      Tweet.new(tweet_result)
    end
    # we need to return an array of tweet instances
    # based on what is in the database
  end

  def self.first
    self.all.first
  end

  def initialize(options={})
    @message = options['message']
    @username = options['username']
    @id = options['id']
  end

  def save
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
    self
  end

  def ==(obj)
    self.id == obj.id
  end

end


# Tweet.new
# Tweet.new({'message' => 'Good coffee'})
# Tweet.new({'message' => 'Good coffee', 'username' => 'coffeedad', 'beef' => 'true'})
