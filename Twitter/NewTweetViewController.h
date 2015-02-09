//
//  NewTweetViewController.h
//  Twitter
//
//  Created by Biren Barodia on 2/8/15.
//  Copyright (c) 2015 Biren Barodia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface NewTweetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userTwitterHandle;
- (IBAction)onEditingChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tweetTextField;
@property (nonatomic, strong) NSNumber *replyId;
@property (nonatomic, strong) NSString *replyUsername;

@end
