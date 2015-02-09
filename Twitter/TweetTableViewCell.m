//
//  TweetTableViewCell.m
//  Twitter
//
//  Created by Biren Barodia on 2/8/15.
//  Copyright (c) 2015 Biren Barodia. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "NewTweetViewController.h"
@interface TweetTableViewCell ()

@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    [self refreshImages];
    // Initialization code
    self.tweetText.preferredMaxLayoutWidth = self.tweetText.frame.size.width;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void) layoutSubviews {
    [super layoutSubviews];
    self.tweetText.preferredMaxLayoutWidth = self.tweetText.frame.size.width;
    
}


- (void) refreshImages {
    [self loadRetweetImage];
    [self loadFavoriteImage];
    
}

- (void) setTweet:(Tweet *)tweet   {
    _tweet = tweet;
    [self.authorProfileImage setImageWithURL:[NSURL URLWithString:self.tweet.author.profileImageUrl]];
    self.tweetText.text = tweet.tweet;
    self.authorName.text = tweet.author.name;
    self.authorTwitterHandle.text = [NSString stringWithFormat:@"@%@", tweet.author.screenname ];
}


- (void) retweet {
    [_tweet retweet];
}


- (void) unretweet {
    NSLog(@"Unretweeting not supported");
    // [_tweet unretweet];
}


- (void) unfavoriteTweet {
    [_tweet unfavoriteTweet];
}


- (void) favoriteTweet {
    [_tweet favoriteTweet];
}

- (void) tweet:(Tweet *)tweet didTweetChange:(Tweet *)tweetIn {
    self.tweet = tweetIn;
    [self refreshImages];
    [self setNeedsLayout];
}

- (void) loadFavoriteImage {
    if ( self.tweet.favorited) {
        UIImage *btnImage = [UIImage imageNamed:@"favorite_on.png"];
        [self.favoriteButton setImage:btnImage forState:UIControlStateNormal];
    } else {
        UIImage *btnImage = [UIImage imageNamed:@"favorite.png"];
        [self.favoriteButton setImage:btnImage forState:UIControlStateNormal];
    }
}



- (void) loadRetweetImage {
    if ( self.tweet.retweeted) {
        UIImage *btnImage = [UIImage imageNamed:@"retweet_on.png"];
        [self.retweetButton setImage:btnImage forState:UIControlStateNormal];
    } else {
        UIImage *btnImage = [UIImage imageNamed:@"retweet.png"];
        [self.retweetButton setImage:btnImage forState:UIControlStateNormal];
    }
}



- (IBAction)onFavoriteAction:(id)sender {
    if (_tweet.favorited) {
        [self unfavoriteTweet];
    } else [self favoriteTweet];
}
- (IBAction)onReplyAction:(id)sender {
    NewTweetViewController *ntvc = [[NewTweetViewController alloc] init];
    ntvc.replyId = _tweet.tweetId;
    ntvc.replyUsername = _tweet.author.screenname;
    // UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:ntvc];
    // [[self.superview] presentViewController:nvc animated:YES completion:nil];

}
- (IBAction)onRetweetAction:(id)sender {
    if (_tweet.retweeted) {
        [self unretweet];
    } else [self retweet];
}
@end
