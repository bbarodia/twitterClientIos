//
//  TweetTableViewCell.h
//  Twitter
//
//  Created by Biren Barodia on 2/8/15.
//  Copyright (c) 2015 Biren Barodia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetTableViewCell : UITableViewCell <TweetFavoriteDelegate>

@property (strong, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UILabel *authorTwitterHandle;
@property (weak, nonatomic) IBOutlet UIImageView *authorProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *oldBy;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;


@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
- (IBAction)onFavoriteAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
- (IBAction)onReplyAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
- (IBAction)onRetweetAction:(id)sender;



/*@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
- (IBAction)onRetweet:(id)sender;
- (IBAction)onReplyAction:(id)sender;
- (IBAction)onFavoriteAction:(id)sender;*/
- (void) setTweet:(Tweet *)tweet;
@end