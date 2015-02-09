//
//  MenuViewController.m
//  SlideToDo
//
//  Created by Brandon King on 4/20/13.
//  Copyright (c) 2013 King's Cocoa. All rights reserved.
//

#import "MenuViewController.h"
#import "ECSlidingViewController.h"

@interface MenuViewController() <UITableViewDelegate, UITableViewDataSource>
//@property (nonatomic, weak) IBOutlet UINavigationBar *navigationBar;
@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.slidingViewController setAnchorLeftRevealAmount:280.0f];
    self.slidingViewController.underRightWidthLayout = ECFullWidth;
    
//    self.categoryList = @[];
  //  [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bar"] forBarMetrics:UIBarMetricsDefault];
    

} 

- (IBAction)ErrorReportBtnAction:(id)sender {
    NSLog(@"341234");
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://happysejongcity@gmail.com"]];
  }

- (IBAction)MenuCloseAction:(id)sender {
    [self.slidingViewController resetTopView];

}
@end
