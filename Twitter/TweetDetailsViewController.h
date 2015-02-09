//
//  TweetDetailsViewController.h
//  Twitter
//
//  Created by Biren Barodia on 2/8/15.
//  Copyright (c) 2015 Biren Barodia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetDetailsViewController : UIViewController <TweetFavoriteDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *authorImage;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *authorTwitterHandle;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
- (IBAction)onRetweetTap:(id)sender;
- (IBAction)onReplyTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *onFavoriteTap;
@property (strong, nonatomic) Tweet *tweet;
- (IBAction)onFavorite:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCount;
@property (weak, nonatomic) IBOutlet UILabel *retweetedLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *onRetweetTap;

- (void) setTweet:(Tweet *)tweet;

@end
