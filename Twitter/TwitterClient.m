//
//  TwitterClient.m
//  Twitter
//
//  Created by Biren Barodia on 2/7/15.
//  Copyright (c) 2015 Biren Barodia. All rights reserved.
//

#import "TwitterClient.h"
#import "BDBOAuth1RequestOperationManager.h"
#import "Tweet.h"

NSString * const kTwitterConsumerKey = @"hlTYrnElNQjmERTYtW99AMLqg";
NSString * const kTwitterConsumerSecret = @"KNpPaIuJy3QzaisqfFUea252EhhR2y0OpNorJbfgCm8AFb1tEo";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient ()

@property (nonatomic, strong) void (^loginCompletion) (User *user, NSError *error);

@end

@implementation TwitterClient



+ (TwitterClient *) sharedInstance {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
            
        }
    });
    
    
    return instance;
}

- (void)loginWithCompletion:(void (^)(User *, NSError *))completion {
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token"
                                                       method:@"GET" callbackURL:[NSURL URLWithString:@"birendemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
                                                           NSLog(@"got the request token");
                                                           NSURL *authUrl = [NSURL URLWithString:[ NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
                                                           [[UIApplication sharedApplication] openURL:authUrl];
                                                       } failure:^(NSError *error) {
                                                           NSLog(@"%@", error);
                                                           NSLog(@"fail to get the request token");
                                                           self.loginCompletion (nil, error);
                                                       }];
}


- (void) openURL:(NSURL *)url {
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query]  success:^(BDBOAuth1Credential *accessToken) {
        [self.requestSerializer saveAccessToken:accessToken];
        
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //          NSLog(@"current user %@", responseObject);
            User *user = [[User alloc] initWithDictionary:responseObject];
            self.loginCompletion(user, nil);
            [User setCurrentUser:user];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed %@", error   );
            self.loginCompletion (nil, error);

        }];
        
    } failure:^(NSError *error) {
        NSLog(@"failed got access token");
        self.loginCompletion (nil, error);

        
    }];

}


- (void) homeTimeLineWithParams: (NSDictionary *) params completion:(void (^) (NSArray *tweets, NSError *error))completion {
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tweets = [Tweet tweetsWithArrayDictionaries:responseObject] ;
        completion (tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}


- (void) favoriteTweet: (NSDictionary *) params completion:(void (^) (NSDictionary *tweet, NSError *error))completion {
    [self POST:@"1.1/favorites/create.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
       // NSArray *tweets = [Tweet tweetsWithArrayDictionaries:responseObject] ;
        completion (responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}



- (void) unfavoriteTweet: (NSDictionary *) params completion:(void (^) (NSDictionary *tweet, NSError *error))completion {
    [self POST:@"1.1/favorites/destroy.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode == 200) {
          completion (responseObject, nil);
        } else {
            completion (nil, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}


- (void) newTweet: (NSDictionary *) params completion:(void (^) (NSDictionary *tweet, NSError *error))completion {
    [self POST:@"1.1/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode == 200) {
            completion (responseObject, nil);
        } else {
            completion (nil, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

- (void) retweet: (NSDictionary *) params completion:(void (^) (NSDictionary *tweet, NSError *error))completion {
    [self POST:[NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", params[@"id"]] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode == 200) {
            completion (responseObject, nil);
        } else {
            completion (nil, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

@end
