import tweet
tweet.SPACE = '='
tweet.MENTION_SYMBOL = '*'
tweet.MAX_TWEET_LENGTH = 21
print(tweet.get_nth_tweet("good=afternoon" * 2,
                          tweet.num_tweets_required("good=afternoon" * 2) - 1))
print(tweet.add_hashtag("murdered=by=words", "not_today"))
print(tweet.add_hashtag("murdered=by=words=*words", "words"))
print(tweet.is_mentioned("murdered=by=words=*words", "words"))
tweet.SPACE = '\n'
tweet.MENTION_SYMBOL = '&'
tweet.MAX_TWEET_LENGTH = 2
print(tweet.is_valid_tweet("whoops" * 3895))
print(tweet.compare_tweet_lengths("ab", "cd"))
tweet.MAX_TWEET_LENGTH = 60
tweet.UNDERSCORE = ' '
print(tweet.compare_tweet_lengths("abracadabra", "cd"))
print(tweet.is_mentioned("not\ntoday\nold\nfriend\n&janko is asleep",
                         "janko is asleep"))
print(tweet.add_mention_exclusive("<CODE_BREAKER>janko is asleep", "janko is asleep"))

"""
answers:
ternoon
murdered=by=words
murdered=by=words=*words
True
False
0
1
True
<CODE_BREAKER>janko is asleep
&janko is asleep
"""
