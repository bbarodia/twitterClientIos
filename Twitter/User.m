//
//  User.m
//  Twitter
//
//  Created by Biren Barodia on 2/7/15.
//  Copyright (c) 2015 Biren Barodia. All rights reserved.
//

#import "User.h"
#import "TwitterClient.h"

NSString * const UserDidLoginNotification = @"UserDidLoginNotification";
NSString * const UserDidLogOutNotification = @"UserDidLogOutNotification";

@interface User ()

@property (nonatomic, strong) NSDictionary *dictionary;
@end

@implementation User


- (id) initWithDictionary :(NSDictionary *) dictionary{
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
        self.name = dictionary[@"name"];
        self.screenname = dictionary[@"screen_name"];
        self.profileImageUrl = dictionary[@"profile_image_url"];
        self.tagline   = dictionary[@"description"];
        self.name = dictionary[@"name"];
        
    }
    
    return self;
}


NSString * const kCurrentUserKey = @"currentUserKey";
static User *_currentUser = nil;
+ (User *) currentUser {
    if (_currentUser == nil){
        NSData *userDataFromDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUserKey];
        if (userDataFromDefaults != nil) {
            NSDictionary *userDictionary = [NSJSONSerialization  JSONObjectWithData:userDataFromDefaults options:0 error:NULL];
            _currentUser = [[User alloc] initWithDictionary:userDictionary];
        }
    }
    return _currentUser;
}
+ (void) setCurrentUser:(User *) currentUser{
    
    _currentUser = currentUser;
    if (_currentUser != nil) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:currentUser.dictionary options:0 error:NULL];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrentUserKey];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kCurrentUserKey];

    }
    [[NSUserDefaults standardUserDefaults] synchronize];

}

+ (void) logout {
    [User setCurrentUser:nil];
    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogOutNotification object:nil];
}

@end
