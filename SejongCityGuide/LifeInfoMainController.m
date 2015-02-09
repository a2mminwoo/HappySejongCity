//
//  LifeInfoMainController.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 2. 9..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "LifeInfoMainController.h"
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
@interface LifeInfoMainController ()

@end

@implementation LifeInfoMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![self.slidingViewController.underRightViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underRightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuView"];
    }
    //  [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}
- (IBAction)btnMenuAction:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECLeft];
}



@end
