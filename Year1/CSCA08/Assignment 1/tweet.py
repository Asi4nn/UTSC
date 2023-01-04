"""Assignment 1.
"""

import math

# Maximum number of characters in a valid tweet.
MAX_TWEET_LENGTH = 50

# The first character in a hashtag.
HASHTAG_SYMBOL = '#'

# The first character in a mention.
MENTION_SYMBOL = '@'

# Underscore is the only non-alphanumeric character that can be part
# of a word (or username) in a tweet.
UNDERSCORE = '_'

SPACE = ' '


def is_valid_tweet(text: str) -> bool:
    """Return True if and only if text contains between
    1 and MAX_TWEET_LENGTH characters (inclusive).

    >>> is_valid_tweet('Hello Twitter!')
    True
    >>> is_valid_tweet('')
    False
    >>> is_valid_tweet(2 * 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')
    False
    """

    return len(text) <= MAX_TWEET_LENGTH and len(text) >= 1


def compare_tweet_lengths(t1: str, t2: str) -> int:
    """Returns one of three integers: 1, if the length of
    t1 is larger than the length of t2; -1, if the length
    of t2 is larger than the length of t1; or 0, if the
    length of t1 and t2 are the same.

    Precondition: t1 and t2 are valid tweets

    >>> compare_tweet_lengths('leo','wang')
    -1
    >>> compare_tweet_lengths('tweet','func')
    1
    >>> compare_tweet_lengths('same','size')
    0
    """

    if len(t1) > len(t2):
        return 1
    elif len(t2) > len(t1):
        return -1
    else:
        return 0


def add_hashtag(tweet: str, tword: str) -> str:
    """Returns tweet with the following appended onto it:
    SPACE, HASHTAG_SYMBOL, and tword. If the resultant
    string is not valid, return tweet.

    Precondition: tweet is a valid tweet, tword is a valid tweet word

    >>> add_hashtag('I like','cscA08')
    'I like #cscA08'
    >>> add_hashtag('Long hashtag', '1234567890' * 5)
    'Long hashtag'
    """

    if is_valid_tweet(tweet + SPACE + HASHTAG_SYMBOL + tword):
        return tweet + SPACE + HASHTAG_SYMBOL + tword
    return tweet


def contains_hashtag(tweet: str, tword: str) -> bool:
    """Returns True if tweet contains a hashtag made
    from a HASHTAG_SYMBOL and tword, and returns False
    otherwise.

    Precondition: tweet is a valid tweet, tword is a valid tweet word

    >>> contains_hashtag('I like #cscA08','cscA08')
    True
    >>> contains_hashtag('I like #cscA08','csc')
    False
    """

    if HASHTAG_SYMBOL + tword + SPACE in clean(tweet) + SPACE:
        return True
    return False


def is_mentioned(tweet: str, tword: str) -> bool:
    """Returns True if tweet contains a mention made
    from a mention symbol and tword, and returns False
    otherwise.

    Precondition: tweet is a valid tweet, tword is a valid tweet word

    >>> is_mentioned('Go @Raptors!','Raptors')
    True
    >>> is_mentioned('Go @Raptors!','Rap')
    False
    """

    if MENTION_SYMBOL + tword + SPACE in clean(tweet) + SPACE:
        return True
    return False


def add_mention_exclusive(tweet: str, tword: str) -> str:
    """Returns tweet with the following appended onto
    it: SPACE, MENTION_SYMBOL, and tword.
    If the resultant string is not valid or has a mention using
    tword, return tweet.

    Precondition: tweet is a valid tweet, tword is a valid tweet word

    >>> add_mention_exclusive('Go Raptors!', 'Raptors')
    'Go Raptors! @Raptors'
    >>> add_mention_exclusive('Go @Raptors!', 'Raptors')
    'Go @Raptors!'
    """

    if is_mentioned(tweet, tword) is False:
        if is_valid_tweet(tweet + SPACE + MENTION_SYMBOL + tword):
            return tweet + SPACE + MENTION_SYMBOL + tword
    return tweet


def num_tweets_required(message: str) -> int:
    """Returns the minimum number of tweets required
    to communiate all of message

    >>> num_tweets_required('One message')
    1
    >>> num_tweets_required('1'*51)
    2
    """

    return math.ceil(len(message)/MAX_TWEET_LENGTH)


def get_nth_tweet(message: str, n: int) -> str:
    """Return the nth valid tweet that is required to
    represent all of message.

    Precondition: 0 <= n <= number of tweets required to display message

    >>> get_nth_tweet('one', 0)
    'one'
    >>> get_nth_tweet('fifty'*10 + 'pastfifty',1)
    'pastfifty'
    """
    if n < num_tweets_required(message) - 1:
        return message[MAX_TWEET_LENGTH * n:MAX_TWEET_LENGTH * (n-1) - 1]
    return message[MAX_TWEET_LENGTH * n:]

# A helper function.  Do not modify this function, but you are welcome
# to call it.


def clean(text: str) -> str:
    """Return text with every non-alphanumeric character, except for
    HASHTAG_SYMBOL, MENTION_SYMBOL, and UNDERSCORE, replaced with a
    SPACE, and each HASHTAG_SYMBOL replaced with a SPACE followed by
    the HASHTAG_SYMBOL, and each MENTION_SYMBOL replaced with a SPACE
    followed by a MENTION_SYMBOL.

    >>> clean('A! lot,of punctuation?!!')
    'A  lot of punctuation   '
    >>> clean('With#hash#tags? and@mentions?in#twe_et #end')
    'With #hash #tags  and @mentions in #twe_et  #end'
    """

    clean_str = ''
    for char in text:
        if char.isalnum() or char == UNDERSCORE:
            clean_str = clean_str + char
        elif char == HASHTAG_SYMBOL or char == MENTION_SYMBOL:
            clean_str = clean_str + SPACE + char
        else:
            clean_str = clean_str + SPACE
    return clean_str

print(add_mention_exclusive('#Does @not? contain, mention; word!', 'foobar'))
