//
//  MainController.m
//  SejongCityGuide
//
//  Created by 민우임 on 2015. 1. 26..
//  Copyright (c) 2015년 A2M. All rights reserved.
//

#import "TrafficMainController.h"
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
//#import "InitialTraffic.h"


@implementation TrafficMainController

-(void)viewDidLoad
{


    [super viewDidLoad];
    [self setConnectIv];
}

-(void)setConnectIv{
    UITapGestureRecognizer *trafficTapMenu01 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionTrafficTaxi:)];
    [self.trafficBtn01 addGestureRecognizer:trafficTapMenu01];
}

- (IBAction)tapActionTrafficTaxi:(id)sender{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    TrafficMainController *viewController = (TrafficMainController *)[storyboard instantiateViewControllerWithIdentifier:@"trafficTaxi"];
    [self presentViewController:viewController animated:YES completion:nil];
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
