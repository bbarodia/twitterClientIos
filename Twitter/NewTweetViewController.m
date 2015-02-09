//
//  NewTweetViewController.m
//  Twitter
//
//  Created by Biren Barodia on 2/8/15.
//  Copyright (c) 2015 Biren Barodia. All rights reserved.
//

#import "NewTweetViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "Tweet.h"
@interface NewTweetViewController ()

@end

@implementation NewTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    User *user = [User currentUser];
    self.userName.text = user.name;
    [self.userProfileImage setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    self.userTwitterHandle.text = [NSString stringWithFormat:@"@%@", user.screenname ];
    
    UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStyleBordered target:self action:@selector(onTweet)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(onCancel)];
    self.navigationItem.leftBarButtonItem = tweetButton;
    self.navigationItem.rightBarButtonItem = cancelButton;

    [self.tweetTextField becomeFirstResponder];
    
    if ( self.replyId != nil) {
        [self.tweetTextField setText:[NSString stringWithFormat:@"@%@ ",self.replyUsername]];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onTweet {
    NSMutableDictionary *newTweetDictionary = [NSMutableDictionary dictionary];
    [newTweetDictionary setObject:self.tweetTextField.text forKey:@"status"];
    if ( self.replyId != nil) {
        [newTweetDictionary setObject:self.replyId forKey:@"in_reply_to_status_id"];

    }
        [[TwitterClient sharedInstance] newTweet:newTweetDictionary completion:^(NSDictionary *tweetDictionary, NSError *error) {
            Tweet *tweet = [[Tweet alloc] initWithDictionary:tweetDictionary];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
}

- (void) onCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onEditingChanged:(id)sender {
    self.navigationItem.title = [NSString stringWithFormat:@"%ld", self.tweetTextField.text.length];
}
@end
