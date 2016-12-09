## Challenges 

1. Fix our save method so that if the method is called on an existing database row, it updates that row instead of creating a new one

2. Implement the `find` method on our tweet class that finds a tweet by ID and returns it.
IF there is not tweet with that ID, it should raise an error.
```ruby
tweet = Tweet.find(1)
tweet #=> <Tweet slaksjfd @id=1 >
tweet = Tweet.find(48957348)
### No tweet found
```

3. Implement the method where to make the following code work

```ruby
tweets = Tweet.where('username' => 'coffeedad')
tweets #=> [an array of tweet instances with username coffeedad]

tweets = Tweet.where('username' => 'beef')
tweets #=> [] empty array, there are no tweets with username beef
```
