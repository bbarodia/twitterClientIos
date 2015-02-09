//
//  TweetDetailsViewController.m
//  Twitter
//
//  Created by Biren Barodia on 2/8/15.
//  Copyright (c) 2015 Biren Barodia. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "NewTweetViewController.h"
@interface TweetDetailsViewController ()

@end

@implementation TweetDetailsViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_tweet != nil) {
        _tweet.delegate = self;
        [self loadUnChangingProperties];
        [self loadChangingProperties];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) layoutSubviews {
    self.tweetText.preferredMaxLayoutWidth = self.tweetText.frame.size.width;
    
}

- (IBAction)onRetweetTap:(id)sender {
    if (_tweet.retweeted) {
        [self unretweet];
    } else [self retweet];
}

- (IBAction)onReplyTap:(id)sender {
    NewTweetViewController *ntvc = [[NewTweetViewController alloc] init];
    ntvc.replyId = _tweet.tweetId;
    ntvc.replyUsername = _tweet.author.screenname;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:ntvc];
    
    [self presentViewController:nvc animated:YES completion:nil];
}

- (IBAction)onFavorite:(id)sender {
    
    if (_tweet.favorited) {
        [self unfavoriteTweet];
    } else [self favoriteTweet];
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

- (void) setTweet:(Tweet *)tweet   {
    _tweet = tweet;
}

- (void)loadUnChangingProperties {
    [self.authorImage setImageWithURL:[NSURL URLWithString:self.tweet.author.profileImageUrl]];
    self.tweetText.text = _tweet.tweet;
    self.authorName.text = _tweet.author.name;
    NSLog(@"%@", [NSString stringWithFormat:@"@%@", _tweet.author.screenname ]);
    self.authorTwitterHandle.text = [NSString stringWithFormat:@"@%@", _tweet.author.screenname ];
}


- (void)loadChangingProperties {
    self.retweetedLabel.text = [NSString stringWithFormat:@"%d RETWEETED", _tweet.retweetedCount];
    self.favoriteCount.text = [NSString stringWithFormat:@"%d FAVORITED", _tweet.favoritedCount];
    [self loadFavoriteImage];
    [self loadRetweetImage];
}

- (void) tweet:(Tweet *)tweet didTweetChange:(Tweet *)tweetIn {
    self.tweet = tweetIn;
    _tweet.delegate = self;
    [self loadChangingProperties];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
