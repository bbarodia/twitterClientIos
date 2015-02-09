//
//  TweetViewController.m
//  Twitter
//
//  Created by Biren Barodia on 2/8/15.
//  Copyright (c) 2015 Biren Barodia. All rights reserved.
//

#import "TweetViewController.h"
#import "User.h"
#import "Tweet.h"
#import "TwitterClient.h"
#import "TweetTableViewCell.h"
#import "TweetDetailsViewController.h"
#import "NewTweetViewController.h"
@interface TweetViewController  ()
- (IBAction)onLogoutTappedAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tweetsTable;
@property (strong, nonatomic) UIRefreshControl *refControl;
@property (strong, nonatomic) NSArray *tweets;
@end

@implementation TweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkAndReloadTweets];
    
    self.refControl = [[UIRefreshControl alloc] init];
    [self.refControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout)];
    UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet)];
    self.navigationItem.leftBarButtonItem = logoutButton;
    self.navigationItem.rightBarButtonItem = tweetButton;

    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Twitter_logo_blue_32.png"]];
    self.navigationItem.titleView = logoView;

    
    self.tweetsTable.dataSource = self;
    self.tweetsTable.delegate = self;

    [self.tweetsTable registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"TweetTableViewCell"];
    self.tweetsTable.rowHeight = UITableViewAutomaticDimension;
    [self.tweetsTable insertSubview:self.refControl atIndex:0];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TweetDetailsViewController *tDetailsvc = [[TweetDetailsViewController alloc] init];
    tDetailsvc.tweet = self.tweets[indexPath.row] ;
    [self.navigationController pushViewController:tDetailsvc animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *tweetTableViewCell = [self.tweetsTable dequeueReusableCellWithIdentifier:@"TweetTableViewCell"];
    tweetTableViewCell.tweet = ((Tweet* )_tweets[indexPath.row]);
    tweetTableViewCell.tweet.delegate = tweetTableViewCell;
    return tweetTableViewCell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) onLogout {
    [User logout];
}


- (void) onTweet {
    NSLog(@" Clicked Tweet - Implement it");
    NewTweetViewController *ntvc = [[NewTweetViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:ntvc];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void) checkAndReloadTweets {
    [[TwitterClient sharedInstance] homeTimeLineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        self.tweets = tweets;
        [self.tweetsTable reloadData];
    }];
}

- (void)onRefresh {
    
    NSLog(@"refreshing");
    [self checkAndReloadTweets];
    [self.refControl endRefreshing];
}
@end
