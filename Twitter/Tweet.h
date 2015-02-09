//
//  Tweet.h
//  Twitter
//
//  Created by Biren Barodia on 2/7/15.
//  Copyright (c) 2015 Biren Barodia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"


@class Tweet;

@protocol TweetFavoriteDelegate <NSObject>

- (void)tweet: (Tweet *) tweet didTweetChange: (Tweet *) tweet;

@end


@interface Tweet : NSObject


@property (nonatomic, weak) id<TweetFavoriteDelegate> delegate;

@property (nonatomic, strong) NSString *tweet;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *author;
@property (nonatomic, strong) NSNumber *tweetId;
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, assign) BOOL retweeted;
@property (nonatomic, assign) int retweetedCount;
@property (nonatomic, assign) int favoritedCount;

- (id) initWithDictionary :(NSDictionary *) dictionary;

+ (NSArray *) tweetsWithArrayDictionaries:(NSArray *) array;

- (void) favoriteTweet ;
- (void) unfavoriteTweet ;
- (void) retweet ;

@end
