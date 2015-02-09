//
//  Tweet.m
//  Twitter
//
//  Created by Biren Barodia on 2/7/15.
//  Copyright (c) 2015 Biren Barodia. All rights reserved.
//

#import "Tweet.h"
#import "TwitterClient.h"

@implementation Tweet

- (id) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        NSLog(@"%@", dictionary);
        self.author = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.tweet = dictionary[@"text"];
        NSString *created = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt  = [formatter dateFromString:created];
        self.tweetId = [NSNumber numberWithLong:[dictionary[@"id"] longValue]];
        self.retweetedCount = [dictionary[@"retweet_count"] integerValue];
        self.favoritedCount = [dictionary[@"favorite_count"] integerValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
    }
    return self;
}


- (id) updateWithDictionary:(NSDictionary *)dictionary {
    if (self && dictionary !=nil) {
        NSLog(@"%@", dictionary);
        self.retweetedCount = [dictionary[@"retweet_count"] integerValue];
        self.favoritedCount = [dictionary[@"favorite_count"] integerValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
    }
    return self;
}

+ (NSArray *) tweetsWithArrayDictionaries:(NSArray *)array {
    NSMutableArray * arrayOfTweets = [NSMutableArray array];
    for (NSDictionary *dictionary in array) {
        [arrayOfTweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    
    return arrayOfTweets;
}

- (void) favoriteTweet {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:self.tweetId forKey:@"id"];
    [[TwitterClient sharedInstance] favoriteTweet:param completion:^(NSDictionary *tweetDictionary, NSError *error) {
        [self updateWithDictionary:tweetDictionary];
        [self.delegate tweet:self didTweetChange:self];
    }];
}


- (void) unfavoriteTweet {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:self.tweetId forKey:@"id"];
    [[TwitterClient sharedInstance] unfavoriteTweet:param completion:^(NSDictionary *tweetDictionary, NSError *error) {
        [self updateWithDictionary:tweetDictionary];
        [self.delegate tweet:self didTweetChange:self];
    }];
}


- (void) retweet {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:self.tweetId forKey:@"id"];
    [[TwitterClient sharedInstance] retweet:param completion:^(NSDictionary *tweetDictionary, NSError *error) {
        [self updateWithDictionary:tweetDictionary];
        [self.delegate tweet:self didTweetChange:self];
    }];
}

@end

