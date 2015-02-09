//
//  User.h
//  Twitter
//
//  Created by Biren Barodia on 2/7/15.
//  Copyright (c) 2015 Biren Barodia. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString * const UserDidLoginNotification ;
extern NSString * const UserDidLogOutNotification ;


@interface User : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *screenname;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *tagline;

- (id) initWithDictionary :(NSDictionary *) dictionary;

+ (User *) currentUser;
+ (void) setCurrentUser:(User *) currentUser;
+ (void) logout;
@end
