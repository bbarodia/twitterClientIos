//
//  LoginViewController.m
//  Twitter
//
//  Created by Biren Barodia on 2/7/15.
//  Copyright (c) 2015 Biren Barodia. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)onLogin:(id)sender;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            //modally present tweets view
           // NSLog(@"Welcome user %@", user.name);
            TweetViewController *lvc = [[TweetViewController alloc] init];
            UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:lvc];

            [self presentViewController:nv animated:YES completion:nil];
        } else {
            // present error
        }
    }];
    
}
@end
