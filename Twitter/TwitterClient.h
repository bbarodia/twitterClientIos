//
//  TwitterClient.h
//  Twitter
//
//  Created by Biren Barodia on 2/7/15.
//  Copyright (c) 2015 Biren Barodia. All rights reserved.
//
#import "BDBOAuth1RequestOperationManager.h"

#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *) sharedInstance ;

- (void) loginWithCompletion:(void (^)(User *user, NSError *error)) completion;
- (void) openURL:(NSURL *)url;
- (void) favoriteTweet: (NSDictionary *) params completion:(void (^) (NSDictionary *tweet, NSError *error))completion ;
- (void) unfavoriteTweet: (NSDictionary *) params completion:(void (^) (NSDictionary *tweet, NSError *error))completion ;
- (void) homeTimeLineWithParams: (NSDictionary *) params completion:(void (^) (NSArray *tweets, NSError *error))completion ;
- (void) newTweet: (NSDictionary *) params completion:(void (^) (NSDictionary *tweet, NSError *error))completion ;
- (void) retweet: (NSDictionary *) params completion:(void (^) (NSDictionary *tweet, NSError *error))completion ;

@end
